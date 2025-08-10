# Flashboard - iPhone Message Display App

Flashboard is an intuitive and viral iPhone app designed to display messages prominently on the screen, perfect for concerts, events, protests, or any situation where you need to get your message across clearly.

## Features

### ✨ Core Functionality
- **Message Input**: Easy text input with support for multi-line messages
- **Full-Screen Display**: Messages take up the entire screen for maximum visibility
- **Orientation Support**: Works in both portrait and landscape modes

### 🎨 Text Customization
- **Font Selection**: Choose from 8 professional fonts including Helvetica-Bold, Impact, and Futura
- **Font Size**: Adjustable from 20px to 200px for optimal viewing distance
- **Text Color**: 15 vibrant color options for maximum contrast and visibility

### 🌈 Background Customization
- **Background Colors**: 15 color options including white, black, and bright colors
- **Smart Contrast**: Ensures text remains readable on any background

### 🎭 Display Modes
- **Static Display**: Traditional non-moving message display
- **Scrolling Display**: Horizontal marquee effect with adjustable speed
- **Speed Control**: Fine-tune scrolling speed from 0.1x to 3.0x

### ✨ Special Effects
- **Blinking Effect**: Make your message flash for attention
- **Frequency Control**: Adjust blink rate from 0.1 to 3.0 seconds
- **Smooth Animations**: Professional-grade animations for all effects

### 💾 Template Management
- **Save Templates**: Save your favorite message configurations
- **Quick Access**: Load saved templates instantly
- **Duplicate & Edit**: Copy and modify existing templates
- **Export/Import**: Share templates with friends

## How to Use

### 1. Quick Start
1. Open the app and type your message
2. Tap "Quick Display" to see it immediately
3. Use the back button to return to editing

### 2. Customize Your Message
1. Tap "Customize & Display" to open settings
2. Choose your preferred font, size, and colors
3. Select display mode (static or scrolling)
4. Add special effects like blinking
5. Preview your message

### 3. Save for Later
1. Customize your message to perfection
2. Tap "Save Template" and give it a name
3. Access saved templates from the main screen
4. Load and modify templates anytime

### 4. Full-Screen Display
1. Tap "Quick Display" or "Customize & Display"
2. Your message appears in full-screen mode
3. Use the overlay buttons to navigate back or access settings
4. Perfect for holding up at events or concerts

## Technical Requirements

- **iOS Version**: iOS 17.0 or later
- **Devices**: iPhone and iPad (Universal app)
- **Orientation**: Portrait and Landscape support
- **Architecture**: SwiftUI with MVVM pattern

## Architecture

The app follows modern iOS development best practices:

- **SwiftUI**: Modern declarative UI framework
- **MVVM Pattern**: Clean separation of concerns
- **ObservableObject**: Reactive data management
- **UserDefaults**: Local template storage
- **Codable**: JSON serialization for templates

## File Structure

```
FlashboardApp/
├── FlashboardAppApp.swift      # Main app entry point
├── ContentView.swift           # Main interface
├── MessageDisplayView.swift    # Full-screen display
├── SettingsView.swift          # Customization interface
├── MessageTemplate.swift       # Data model
├── MessageManager.swift        # Business logic
├── Assets.xcassets/            # App icons and colors
└── Info.plist                 # App configuration
```

## Design Principles

### 🎯 User Experience
- **Intuitive Interface**: Easy to use even for first-time users
- **Quick Actions**: Get your message displayed in seconds
- **Visual Feedback**: Clear indicators for all interactions

### 🎨 Visual Design
- **Modern iOS**: Follows Apple's Human Interface Guidelines
- **Accessibility**: High contrast and readable text
- **Responsive**: Adapts to all iPhone screen sizes

### ⚡ Performance
- **Smooth Animations**: 60fps scrolling and effects
- **Battery Efficient**: Optimized for extended use
- **Fast Loading**: Instant template switching

## Use Cases

### 🎵 Concerts & Events
- Hold up song requests
- Show support for your favorite artist
- Display fan messages

### 📢 Protests & Activism
- Clear, visible messaging
- Support for causes
- Community communication

### 🏟️ Sports Events
- Team support messages
- Player appreciation
- Game day excitement

### 🎉 Parties & Celebrations
- Birthday wishes
- Congratulations
- Special announcements

### 🚨 Emergency Situations
- Clear communication
- High visibility
- Quick message display

## Future Enhancements

- **Cloud Sync**: Share templates across devices
- **Social Features**: Share messages on social media
- **Advanced Effects**: More animation options
- **Voice Input**: Speech-to-text for quick messaging
- **Widgets**: Quick access from home screen

## Getting Started

1. **Open in Xcode**: Open the `.xcodeproj` file in Xcode 15+
2. **Select Target**: Choose your iPhone simulator or device
3. **Build & Run**: Press Cmd+R to build and run the app
4. **Test Features**: Try all the customization options
5. **Save Templates**: Create and save your favorite configurations

## Contributing

This is a personal project, but suggestions and feedback are welcome! The app is designed to be easily extensible for future features.

## License

This project is created for educational and personal use. Feel free to modify and adapt for your own projects.

---

**Flashboard** - Make your message impossible to miss! 📱✨
