import SwiftUI
import Foundation

class MessageManager: ObservableObject {
    @Published var templates: [MessageTemplate] = []
    @Published var currentTemplate: MessageTemplate
    
    private let templatesKey = "SavedTemplates"
    
    init() {
        self.currentTemplate = MessageTemplate()
        loadTemplates()
    }
    
    // MARK: - Template Management
    func saveTemplate(_ template: MessageTemplate) {
        if let index = templates.firstIndex(where: { $0.id == template.id }) {
            templates[index] = template
        } else {
            templates.append(template)
        }
        saveTemplates()
    }
    
    func deleteTemplate(_ template: MessageTemplate) {
        templates.removeAll { $0.id == template.id }
        saveTemplates()
    }
    
    func loadTemplate(_ template: MessageTemplate) {
        currentTemplate = template
    }
    
    func createNewTemplate() {
        currentTemplate = MessageTemplate()
    }
    
    func resetToDefaults() {
        currentTemplate = MessageTemplate()
    }
    
    // MARK: - Persistence
    private func saveTemplates() {
        if let encoded = try? JSONEncoder().encode(templates) {
            UserDefaults.standard.set(encoded, forKey: templatesKey)
        }
    }
    
    private func loadTemplates() {
        if let data = UserDefaults.standard.data(forKey: templatesKey),
           let decoded = try? JSONDecoder().decode([MessageTemplate].self, from: data) {
            templates = decoded
        }
    }
    
    // MARK: - Quick Actions
    func duplicateTemplate(_ template: MessageTemplate) {
        var newTemplate = template
        newTemplate.name = "\(template.name) (Copy)"
        newTemplate.id = UUID()
        newTemplate.createdAt = Date()
        saveTemplate(newTemplate)
    }
    
    func exportTemplate(_ template: MessageTemplate) -> String? {
        if let encoded = try? JSONEncoder().encode(template) {
            return String(data: encoded, encoding: .utf8)
        }
        return nil
    }
    
    func importTemplate(from jsonString: String) -> MessageTemplate? {
        guard let data = jsonString.data(using: .utf8),
              let template = try? JSONDecoder().decode(MessageTemplate.self, from: data) else {
            return nil
        }
        return template
    }
}
