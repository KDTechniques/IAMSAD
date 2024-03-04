//
//  ProfileViewModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-03.
//

import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    // MARK: - PRORPERTIES
    let coverPhotoFrameStaticMaxY: CGFloat = 140
    let coverMaxExtraHeight: CGFloat = -43
    @Published var contentOffset: CGPoint = .zero
    @Published var throttledContentOffset: CGPoint = .zero
    @Published var profileContentHeight: CGFloat = .zero
    var cancellable: Set<AnyCancellable> = []
    
    // MARK: Singleton
    static let shared: ProfileViewModel = .init()
    
    // MARK: - INITIALAIER
    init() { contentOffsetSubscriber() }
    
    // MARK: - FUNCTIONS
    
    // MARK: contentOffsetSubscriber
    func contentOffsetSubscriber() {
        $contentOffset
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                let conditionValue: CGFloat = profileContentHeight - coverPhotoFrameStaticMaxY - coverMaxExtraHeight
                
                if newValue.y <= conditionValue {
                    throttledContentOffset = newValue
                } else {
                    throttledContentOffset.y = conditionValue
                }
            }
            .store(in: &cancellable)
    }
}
