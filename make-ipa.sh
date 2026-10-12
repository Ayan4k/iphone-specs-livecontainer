#!/bin/zsh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILD="$ROOT/build"
ARCHIVE="$BUILD/iPhoneSpecs.xcarchive"

rm -rf "$BUILD"
xcodebuild archive \
  -project "$ROOT/iPhoneSpecs.xcodeproj" \
  -scheme iPhoneSpecs \
  -configuration Release \
  -sdk iphoneos \
  -archivePath "$ARCHIVE" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO

mkdir -p "$BUILD/Payload"
cp -R "$ARCHIVE/Products/Applications/iPhoneSpecs.app" "$BUILD/Payload/"
(
  cd "$BUILD"
  /usr/bin/zip -qry "iPhoneSpecs.ipa" Payload
)
rm -rf "$BUILD/Payload"
echo "Created $BUILD/iPhoneSpecs.ipa"
