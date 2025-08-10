import SwiftUI

struct ContentView: View {
    @StateObject private var messageManager = MessageManager()
    @State private var showingSettings = false
    @State private var showingDisplay = false
    @State private var showingTemplates = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App Header
                VStack(spacing: 8) {
                    Image(systemName: "message.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Flashboard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Create stunning message displays")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Quick Message Input
                VStack(spacing: 16) {
                    TextField("Type your message here...", text: $messageManager.currentTemplate.text, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                        .font(.title2)
                    
                    Button("Customize & Display") {
                        showingSettings = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding(.horizontal, 20)
                
                // Quick Actions
                VStack(spacing: 12) {
                    Button("Quick Display") {
                        showingDisplay = true
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button("Saved Templates") {
                        showingTemplates = true
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Recent Templates
                if !messageManager.templates.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Templates")
                            .font(.headline)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(messageManager.templates.prefix(5)) { template in
                                    TemplateCard(template: template) {
                                        messageManager.loadTemplate(template)
                                        showingDisplay = true
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(messageManager: messageManager)
        }
        .fullScreenCover(isPresented: $showingDisplay) {
            MessageDisplayView(template: messageManager.currentTemplate)
                .overlay(
                    VStack {
                        HStack {
                            Button("Back") {
                                showingDisplay = false
                            }
                            .buttonStyle(BackButtonStyle())
                            
                            Spacer()
                            
                            Button("Settings") {
                                showingDisplay = false
                                showingSettings = true
                            }
                            .buttonStyle(BackButtonStyle())
                        }
                        .padding()
                        
                        Spacer()
                    }
                )
        }
        .sheet(isPresented: $showingTemplates) {
            TemplatesView(messageManager: messageManager)
        }
    }
}

// MARK: - Template Card View
struct TemplateCard: View {
    let template: MessageTemplate
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                Text(template.name.isEmpty ? "Untitled" : template.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(template.text)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Circle()
                        .fill(template.textColor)
                        .frame(width: 12, height: 12)
                    
                    Circle()
                        .fill(template.backgroundColor)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    
                    Spacer()
                    
                    Text(template.displayMode.displayName)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .frame(width: 200, height: 120)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Templates View
struct TemplatesView: View {
    @ObservedObject var messageManager: MessageManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(messageManager.templates) { template in
                    TemplateRow(template: template, messageManager: messageManager)
                }
                .onDelete(perform: deleteTemplates)
            }
            .navigationTitle("Saved Templates")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func deleteTemplates(offsets: IndexSet) {
        for index in offsets {
            messageManager.deleteTemplate(messageManager.templates[index])
        }
    }
}

// MARK: - Template Row View
struct TemplateRow: View {
    let template: MessageTemplate
    @ObservedObject var messageManager: MessageManager
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(template.name.isEmpty ? "Untitled" : template.name)
                    .font(.headline)
                
                Text(template.text)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text("Created: \(template.createdAt, style: .date)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Button("Load") {
                    messageManager.loadTemplate(template)
                }
                .buttonStyle(.bordered)
                
                Button("Duplicate") {
                    messageManager.duplicateTemplate(template)
                }
                .buttonStyle(.bordered)
                .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Custom Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct BackButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
