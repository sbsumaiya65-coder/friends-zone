#!/bin/bash
echo "=== Termux Auto-Diagnostics & Repair Started ==="
export PATH="$PATH:$HOME/flutter/bin"
echo "Checking Dart SDK binary..."
if [ ! -f "$HOME/flutter/bin/cache/dart-sdk/bin/dart" ]; then
  echo "Dart SDK missing. Forcing flutter precache..."
  flutter precache --force
else
  echo "Dart SDK found. Fixing permissions & shebangs..."
  termux-fix-shebang $HOME/flutter/bin/cache/dart-sdk/bin/dart
  chmod +x $HOME/flutter/bin/cache/dart-sdk/bin/dart
fi
echo "Cleaning project build caches..."
cd ~/friends_zone
flutter clean
echo "Fetching dependencies fresh..."
flutter pub get
echo "Running final build..."
flutter build apk --debug
echo "=== Auto-Repair & Build Process Completed ==="
