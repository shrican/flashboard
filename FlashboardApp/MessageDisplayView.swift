import SwiftUI

struct MessageDisplayView: View {
    let template: MessageTemplate
    @State private var scrollOffset: CGFloat = 0
    @State private var isVisible = true
    @State private var scrollTimer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                template.backgroundColor
                    .ignoresSafeArea()
                
                // Message Text
                if template.displayMode == .scrolling {
                    scrollingText(geometry: geometry)
                } else {
                    staticText
                }
            }
            .onAppear {
                setupEffects()
            }
            .onDisappear {
                cleanupEffects()
            }
        }
        .statusBarHidden()
        .navigationBarHidden(true)
    }
    
    // MARK: - Static Text Display
    private var staticText: some View {
        Text(template.text)
            .font(.custom(template.fontName, size: template.fontSize))
            .foregroundColor(template.textColor)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.1)
            .lineLimit(nil)
            .padding()
            .opacity(isVisible ? 1.0 : 0.0)
            .animation(.easeInOut(duration: template.blinkFrequency), value: isVisible)
    }
    
    // MARK: - Scrolling Text Display
    private func scrollingText(geometry: GeometryProxy) -> some View {
        let textWidth = calculateTextWidth()
        let screenWidth = geometry.size.width
        
        return Text(template.text)
            .font(.custom(template.fontName, size: template.fontSize))
            .foregroundColor(template.textColor)
            .lineLimit(1)
            .offset(x: scrollOffset)
            .onAppear {
                startScrolling(textWidth: textWidth, screenWidth: screenWidth)
            }
    }
    
    // MARK: - Effects Setup
    private func setupEffects() {
        if template.isBlinking {
            startBlinking()
        }
    }
    
    private func cleanupEffects() {
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
    
    // MARK: - Blinking Effect
    private func startBlinking() {
        Timer.scheduledTimer(withTimeInterval: template.blinkFrequency, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                isVisible.toggle()
            }
        }
    }
    
    // MARK: - Scrolling Effect
    private func startScrolling(textWidth: CGFloat, screenWidth: CGFloat) {
        let totalDistance = textWidth + screenWidth
        _ = totalDistance / (100 * template.scrollSpeed)
        
        scrollTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            withAnimation(.linear(duration: 0.016)) {
                scrollOffset -= 2 * template.scrollSpeed
                
                if scrollOffset < -totalDistance {
                    scrollOffset = screenWidth
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func calculateTextWidth() -> CGFloat {
        let font = UIFont(name: template.fontName, size: template.fontSize) ?? UIFont.systemFont(ofSize: template.fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (template.text as NSString).size(withAttributes: attributes)
        return size.width
    }
}

// MARK: - Preview
struct MessageDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        MessageDisplayView(template: MessageTemplate())
    }
}
