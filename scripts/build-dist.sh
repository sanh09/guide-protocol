#!/usr/bin/env bash
# dist/ 의 업로드용 zip 파일을 다시 만든다. 저장소 루트에서 실행: bash scripts/build-dist.sh
# 모든 zip에 라이선스 파일(LICENSE, LICENSE-CC-BY-4.0, NOTICE)을 넣는다.
# 폴더에 그 파일이 없으면 저장소 맨 위의 파일을 넣는다.
set -euo pipefail
cd "$(dirname "$0")/.."
root="$(pwd)"
license_files=(LICENSE LICENSE-CC-BY-4.0 NOTICE)
for f in "${license_files[@]}"; do
  [ -f "$f" ] || { echo "오류: 저장소 맨 위에 $f 가 없습니다" >&2; exit 1; }
done
mkdir -p dist
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# make_zip <원본 폴더> <zip 안의 폴더 이름> <zip 경로>
make_zip() {
  local src="$1" name="$2" out="$3" stage="$tmp/$2"
  rm -rf "$stage" && mkdir -p "$stage"
  (cd "$src" && tar cf - --exclude='evals' --exclude='.DS_Store' .) | (cd "$stage" && tar xf -)
  for f in "${license_files[@]}"; do
    [ -f "$stage/$f" ] || cp "$root/$f" "$stage/$f"
  done
  rm -f "$out"
  (cd "$tmp" && zip -qrX "$root/$out" "$name")
  rm -rf "$stage"
}

if [ -d skills ]; then
  for d in skills/*/; do
    name="$(basename "$d")"
    make_zip "$d" "$name" "dist/$name.zip"
    echo "built dist/$name.zip"
  done
fi
if [ -d plugins ]; then
  for d in plugins/*/; do
    name="$(basename "$d")"
    rm -f "dist/$name-skill.zip"
    make_zip "$d" "$name" "dist/$name-plugin.zip"
    for s in "plugins/$name/skills/"*/; do
      sn="$(basename "$s")"
      make_zip "$s" "$sn" "dist/$sn-skill.zip"
    done
    echo "built dist/$name-plugin.zip and skill zips"
  done
fi
