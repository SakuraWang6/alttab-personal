#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PERSONAL_VERSION="${PERSONAL_VERSION:-1.0.0}"
PERSONAL_DERIVED_DATA="${PERSONAL_DERIVED_DATA:-$REPO_ROOT/.personal-build/DerivedData}"
cd "$REPO_ROOT"
python3 scripts/assets/compile_illustrations.py --check
xcodebuild \
    -project alt-tab-macos.xcodeproj \
    -scheme Release \
    -configuration Release \
    -destination 'generic/platform=macOS' \
    -derivedDataPath "$PERSONAL_DERIVED_DATA" \
    -disableAutomaticPackageResolution \
    -skipPackageUpdates \
    'ARCHS=arm64 x86_64' \
    ONLY_ACTIVE_ARCH=NO \
    CODE_SIGN_IDENTITY=- \
    CODE_SIGN_STYLE=Manual \
    DEVELOPMENT_TEAM= \
    'OTHER_CODE_SIGN_FLAGS=--timestamp=none --deep' \
    "CURRENT_PROJECT_VERSION=$PERSONAL_VERSION" \
    build
PERSONAL_APP="$PERSONAL_DERIVED_DATA/Build/Products/Release/AltTab Personal.app"
codesign --verify --deep --strict --verbose=2 "$PERSONAL_APP"
plutil -lint "$PERSONAL_APP/Contents/Info.plist"
lipo -archs "$PERSONAL_APP/Contents/MacOS/AltTab Personal"
printf 'Built: %s\n' "$PERSONAL_APP"
