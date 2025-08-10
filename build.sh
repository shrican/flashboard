#!/bin/bash

echo "🚀 Building Flashboard iOS App..."
echo "=================================="

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode is not installed or not in PATH"
    echo "Please install Xcode from the App Store"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "FlashboardApp.xcodeproj/project.pbxproj" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -n 1)"
echo ""

# Clean build
echo "🧹 Cleaning previous build..."
xcodebuild clean -project FlashboardApp.xcodeproj -scheme FlashboardApp -configuration Debug

if [ $? -eq 0 ]; then
    echo "✅ Clean successful"
else
    echo "❌ Clean failed"
    exit 1
fi

echo ""

# Build project
echo "🔨 Building project..."
xcodebuild build -project FlashboardApp.xcodeproj -scheme FlashboardApp -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Build successful!"
    echo ""
    echo "Next steps:"
    echo "1. Open FlashboardApp.xcodeproj in Xcode"
    echo "2. Select your target device or simulator"
    echo "3. Press Cmd+R to run the app"
    echo ""
    echo "Or run directly from Xcode:"
    echo "   Product > Run (Cmd+R)"
else
    echo ""
    echo "❌ Build failed!"
    echo "Please check the error messages above and fix any issues"
    exit 1
fi
