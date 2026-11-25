#!/usr/bin/env bash
# dist/ 의 업로드용 zip 파일을 다시 만든다. 저장소 루트에서 실행: bash scripts/build-dist.sh
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist
if [ -d skills ]; then
  for d in skills/*/; do
    name="$(basename "$d")"
    rm -f "dist/$name.zip"
    (cd skills && zip -qr "../dist/$name.zip" "$name" -x '*/evals/*' '*.DS_Store')
    echo "built dist/$name.zip"
  done
fi
if [ -d plugins ]; then
  for d in plugins/*/; do
    name="$(basename "$d")"
    rm -f "dist/$name-plugin.zip" "dist/$name-skill.zip"
    (cd plugins && zip -qr "../dist/$name-plugin.zip" "$name" -x '*/evals/*' '*.DS_Store')
    for s in "plugins/$name/skills/"*/; do
      sn="$(basename "$s")"
      (cd "plugins/$name/skills" && zip -qr "../../../dist/$sn-skill.zip" "$sn" -x '*/evals/*' '*.DS_Store')
    done
    echo "built dist/$name-plugin.zip and skill zips"
  done
fi
