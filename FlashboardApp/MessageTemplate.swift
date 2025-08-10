import SwiftUI
import Foundation

struct MessageTemplate: Identifiable, Codable {
    let id = UUID()
    var name: String
    var text: String
    var fontName: String
    var fontSize: CGFloat
    var textColor: Color
    var backgroundColor: Color
    var displayMode: DisplayMode
    var scrollSpeed: Double
    var isBlinking: Bool
    var blinkFrequency: Double
    var createdAt: Date
    
    init(name: String = "", text: String = "Hello World!", fontName: String = "Helvetica-Bold", fontSize: CGFloat = 72, textColor: Color = .black, backgroundColor: Color = .white, displayMode: DisplayMode = .static, scrollSpeed: Double = 1.0, isBlinking: Bool = false, blinkFrequency: Double = 1.0) {
        self.name = name
        self.text = text
        self.fontName = fontName
        self.fontSize = fontSize
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.displayMode = displayMode
        self.scrollSpeed = scrollSpeed
        self.isBlinking = false
        self.blinkFrequency = blinkFrequency
        self.createdAt = Date()
    }
}

enum DisplayMode: String, CaseIterable, Codable {
    case `static` = "Static"
    case scrolling = "Scrolling"
    
    var displayName: String {
        return self.rawValue
    }
}

// MARK: - Color Codable Extension
extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self.init(hex: hex)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(toHex())
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func toHex() -> String {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return "000000"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let hex = String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        return hex
    }
}
