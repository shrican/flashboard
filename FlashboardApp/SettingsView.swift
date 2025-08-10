import SwiftUI

struct SettingsView: View {
    @ObservedObject var messageManager: MessageManager
    @Environment(\.dismiss) private var dismiss
    @State private var showingSaveDialog = false
    @State private var templateName = ""
    
    // Available fonts
    private let availableFonts = [
        "Helvetica-Bold",
        "Arial-BoldMT",
        "Futura-Bold",
        "Impact",
        "Georgia-Bold",
        "TimesNewRomanPS-BoldMT",
        "Verdana-Bold",
        "TrebuchetMS-Bold"
    ]
    
    // Available colors
    private let availableColors: [Color] = [
        .black, .white, .red, .green, .blue, .yellow, .orange, .purple,
        .pink, .brown, .gray, .cyan, .mint, .indigo, .teal
    ]
    
    var body: some View {
        NavigationView {
            Form {
                // Message Input Section
                Section("Message") {
                    TextField("Enter your message", text: $messageManager.currentTemplate.text, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                // Font Customization Section
                Section("Font") {
                    Picker("Font Family", selection: $messageManager.currentTemplate.fontName) {
                        ForEach(availableFonts, id: \.self) { font in
                            Text(font).tag(font)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Font Size: \(Int(messageManager.currentTemplate.fontSize))")
                        Slider(value: $messageManager.currentTemplate.fontSize, in: 20...200, step: 1)
                    }
                }
                
                // Colors Section
                Section("Colors") {
                    HStack {
                        Text("Text Color")
                        Spacer()
                        ForEach(availableColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(messageManager.currentTemplate.textColor == color ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    messageManager.currentTemplate.textColor = color
                                }
                        }
                    }
                    
                    HStack {
                        Text("Background")
                        Spacer()
                        ForEach(availableColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(messageManager.currentTemplate.backgroundColor == color ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    messageManager.currentTemplate.backgroundColor = color
                                }
                        }
                    }
                }
                
                // Display Mode Section
                Section("Display Mode") {
                    Picker("Mode", selection: $messageManager.currentTemplate.displayMode) {
                        ForEach(DisplayMode.allCases, id: \.self) { mode in
                            Text(mode.displayName).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if messageManager.currentTemplate.displayMode == .scrolling {
                        VStack(alignment: .leading) {
                            Text("Scroll Speed: \(String(format: "%.1f", messageManager.currentTemplate.scrollSpeed))x")
                            Slider(value: $messageManager.currentTemplate.scrollSpeed, in: 0.1...3.0, step: 0.1)
                        }
                    }
                }
                
                // Special Effects Section
                Section("Special Effects") {
                    Toggle("Blinking Effect", isOn: $messageManager.currentTemplate.isBlinking)
                    
                    if messageManager.currentTemplate.isBlinking {
                        VStack(alignment: .leading) {
                            Text("Blink Frequency: \(String(format: "%.1f", messageManager.currentTemplate.blinkFrequency))s")
                            Slider(value: $messageManager.currentTemplate.blinkFrequency, in: 0.1...3.0, step: 0.1)
                        }
                    }
                }
                
                // Actions Section
                Section("Actions") {
                    Button("Preview Message") {
                        // This will be handled by the parent view
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                    
                    Button("Save Template") {
                        showingSaveDialog = true
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.green)
                    
                    Button("Reset to Defaults") {
                        messageManager.resetToDefaults()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Customize Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .alert("Save Template", isPresented: $showingSaveDialog) {
            TextField("Template Name", text: $templateName)
            Button("Save") {
                if !templateName.isEmpty {
                    var template = messageManager.currentTemplate
                    template.name = templateName
                    messageManager.saveTemplate(template)
                    templateName = ""
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Enter a name for this template")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(messageManager: MessageManager())
    }
}
