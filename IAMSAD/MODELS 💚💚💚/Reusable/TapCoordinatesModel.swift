//
//  TapCoordinatesModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-01.
//

import Foundation

enum Profile_TapEventTypes {
    case general, share, more, followers, link
}

struct TapCoordinatesModel: Identifiable, Equatable {
    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    private(set) var frame: CGRect
    let event: Profile_TapEventTypes
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(frame: CGRect, event: Profile_TapEventTypes, action: @escaping () -> Void) {
        self.frame = frame
        self.event = event
        self.action = action
    }
    
    // MARK: Equatable Confirmation
    static func == (lhs: TapCoordinatesModel, rhs: TapCoordinatesModel) -> Bool {
        /// We update the frame because we don't have to update anything else.
        /// In that case, we can use 'id' for equitability as it remains the same even when we update the frame.
        /// So, what actually changes is the frame, not anything else. Therefore, we use the frame for equitability.
        /// Otherwise, if we use 'id' or anything else, the changes of the frame won't be updated to the view.
        /// Equitability, in this sense, checks which value changed to update the view.
        /// If equitability checks with the frame, SwiftUI knows how to update the view accordingly when we change the frame.
        /// However, if we use 'id', nothing happens.
        lhs.frame == rhs.frame
    }
    
    
    // MARK: - FUNCTIONS
    mutating func setFrame(_ frame: CGRect) {
        self.frame = frame
    }
}
