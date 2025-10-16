#!/bin/bash

# Local build script for Stohrer Sax Pad SVG Generator
# This script replicates the GitHub Actions workflow for testing universal binary builds

set -e  # Exit on any error

echo "🔨 Building Stohrer Sax Pad SVG Generator (Universal Binary)"
echo "============================================================"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script only works on macOS"
    exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed"
    exit 1
fi

# Check if required packages are installed
echo "📦 Checking dependencies..."
python3 -c "import svgwrite, tkinter" 2>/dev/null || {
    echo "📦 Installing required packages..."
    pip3 install svgwrite pyinstaller
}

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf dist/ build/ *.app

# Build for Apple Silicon (ARM64)
echo "🏗️  Building for Apple Silicon (ARM64)..."
arch -arm64 pyinstaller --noconsole --onefile --name "StohrerPadGenerator_arm64" --icon=icon.icns main.py

# Build for Intel (x86_64) using Rosetta
echo "🏗️  Building for Intel (x86_64)..."
arch -x86_64 pyinstaller --noconsole --onefile --name "StohrerPadGenerator_x86_64" --icon=icon.icns main.py

# Create proper macOS app bundle
echo "📱 Creating macOS app bundle..."
mkdir -p "StohrerPadGenerator.app/Contents/MacOS"
mkdir -p "StohrerPadGenerator.app/Contents/Resources"

# Create universal binary using lipo
echo "🔗 Creating universal binary..."
lipo -create -output "StohrerPadGenerator.app/Contents/MacOS/StohrerPadGenerator" \
  "dist/StohrerPadGenerator_arm64" \
  "dist/StohrerPadGenerator_x86_64"

# Make executable
chmod +x "StohrerPadGenerator.app/Contents/MacOS/StohrerPadGenerator"

# Create Info.plist for the app bundle
echo "📄 Creating Info.plist..."
cat > "StohrerPadGenerator.app/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>StohrerPadGenerator</string>
    <key>CFBundleIdentifier</key>
    <string>com.stohrer.saxpadgenerator</string>
    <key>CFBundleName</key>
    <string>Stohrer Sax Pad SVG Generator</string>
    <key>CFBundleVersion</key>
    <string>1.3-macOS</string>
    <key>CFBundleShortVersionString</key>
    <string>1.3-macOS</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleIconFile</key>
    <string>icon</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>LSArchitecturePriority</key>
    <array>
        <string>arm64</string>
        <string>x86_64</string>
    </array>
</dict>
</plist>
EOF

# Copy icon to Resources
cp icon.icns "StohrerPadGenerator.app/Contents/Resources/"

# Verify universal binary
echo "🔍 Verifying universal binary..."
echo "File info:"
file "StohrerPadGenerator.app/Contents/MacOS/StohrerPadGenerator"
echo ""
echo "Architecture info:"
lipo -info "StohrerPadGenerator.app/Contents/MacOS/StohrerPadGenerator"

# Remove quarantine attribute and add ad-hoc signature
echo "🔐 Signing app..."
xattr -d com.apple.quarantine "StohrerPadGenerator.app" 2>/dev/null || true
codesign --force --deep --sign - "StohrerPadGenerator.app"

echo ""
echo "✅ Build complete!"
echo "📱 App created: StohrerPadGenerator.app"
echo ""
echo "🧪 To test the app:"
echo "   1. Double-click StohrerPadGenerator.app to launch"
echo "   2. Or run: open StohrerPadGenerator.app"
echo ""
echo "🔍 To verify architectures:"
echo "   lipo -info StohrerPadGenerator.app/Contents/MacOS/StohrerPadGenerator"
echo ""
echo "📊 App size:"
du -sh "StohrerPadGenerator.app"
