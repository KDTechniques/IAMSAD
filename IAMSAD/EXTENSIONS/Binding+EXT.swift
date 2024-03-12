//
//  Binding+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

extension Binding<String> {
    // MARK: - maxCharacters
    func maxCharacters(_ limit: Int) -> Self {
        DispatchQueue.main.async {
            self.wrappedValue = String(self.wrappedValue.prefix(limit))
        }
        
        return self
    }
}

@MainActor
extension Binding<CGPoint> {
    // MARK: - handleContentOffset
    func handleContentOffset() -> Binding<CGPoint> {
        let profileVM: ProfileViewModel = .shared
        let conditionValue: CGFloat = profileVM.profileContentHeight -
        profileVM.coverStaticHeight - profileVM.coverMaxExtraHeight
        
        return Binding {
            self.wrappedValue
        } set: { newValue in
            if self.wrappedValue.y <= conditionValue {
                return self.wrappedValue = newValue
            }
            
            if newValue.y <= conditionValue {
                return self.wrappedValue = newValue
            }
        }
    }
}

