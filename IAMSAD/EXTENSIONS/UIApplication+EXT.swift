//
//  UIApplication+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-16.
//

import UIKit

extension UIApplication {
    // MARK: - endEditing
    func endEditing(_ force: Bool) {
        Self
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .last { $0.isKeyWindow }?
            .endEditing(force)
    }
}
