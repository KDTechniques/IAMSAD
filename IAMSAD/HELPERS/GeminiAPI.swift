//
//  GeminiAPI.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-17.
//

import Foundation
import GoogleGenerativeAI

actor GeminiAPI {
    // MARK: - PROPERTIES
    var apiKey: String {
        guard let key: String = Bundle.main.infoDictionary?["Gemini API Key"] as? String else {
            fatalError("Error: Couldn't find API Key for `Gemini API Key` in the Info.plist.❗️❗️❗️")
            // send analytics here...
        }
        
        return key
    }
    var model: GenerativeModel { .init(name: "gemini-pro", apiKey: apiKey) }
    
    // MARK: - FUNCTIONS
    
    // MARK: - generateTextToTextContent
    func generateTextToTextContent(_ prompt: String) async -> String? {
        do {
            let content = try await model.generateContent(prompt)
            return content.text
        } catch let error {
            print(error.localizedDescription)
            // send analytics here...
            return nil
        }
    }
    
    // MARK: - generateTextImageToTextContent
    func generateTextImageToTextContent() {
        // code goes here...
    }
}
