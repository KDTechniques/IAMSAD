//
//  CustomTransitioningCounterTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-02.
//

import SwiftUI

struct CustomTransitioningCounterTextView: View {
    // MARK: - PROPERTIES
    let count: String
    let previousCount: String
    let textColor: Color
    
    @State private var transition: AnyTransition
    @State private var dynamicText: String?
    let id: String = ""
    
    // MARK: - INITIALIZER
    init(count: String, previousCount: String, textColor: Color = .secondary) {
        self.count = count
        self.previousCount = previousCount
        self.textColor = textColor
        
        let incrementTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .top)
        )
        let decrementTransition: AnyTransition = .asymmetric(
            insertion: .move(edge: .top),
            removal: .move(edge: .bottom)
        )
        
        let count: Int = count.kmStringToInt() ?? 0
        let previousCount: Int = previousCount.kmStringToInt() ?? 0
        
        if count == previousCount {
            self.transition = incrementTransition
        } else {
            self.transition =  count > previousCount
            ? incrementTransition
            : decrementTransition
        }
        
        self.transition = incrementTransition
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Text(dynamicText ?? count)
                .id(dynamicText)
                .foregroundStyle(textColor)
                .transition(transition)
                .animation(.smooth(duration: 0.2), value: dynamicText)
        }
        .font(.footnote)
        .dynamicTypeSize(...DynamicTypeSize.large)
        .frame(width: 50, height: 20, alignment: .leading)
        .clipShape(Rectangle())
        .onAppear { dynamicText = count }
    }
}

// MARK: - PREVIEWS
#Preview("Preview") {
    VStack {
        Preview1()
        Preview2()
    }
}

struct PreviewModel {
    var like: Bool = false
    var count: String
    var previousCount: String = "0"
    
    mutating func updateOnLike(like: Bool = false, count: String, previousCount: String) {
        self.like = like
        self.count = count
        self.previousCount = previousCount
    }
}

// MARK: - Preview1
fileprivate struct Preview1: View {
    
    @State private var item: PreviewModel = .init(like: false, count: "100")
    @State private var item2: PreviewModel = .init(count: "999")
    
    var body: some View {
        HStack {
            HStack(spacing: -12) {
                CustomLikeHeartAnimationView(
                    like: item.like,
                    size: 55,
                    backgroundViewColor: .colorScheme
                )
                
                CustomTransitioningCounterTextView(
                    count: item.count,
                    previousCount: item.previousCount,
                    textColor: item.like ? .heartIconNText : .secondary
                )
                .id(item.count)
            }
            .onTapGesture {
                let like: Bool = item.like
                let count: Int = item.count.kmStringToInt() ?? 0
                let toggledLike: Bool = !like
                var newCount: Int = 0
                
                if toggledLike { newCount = count+1 } else { newCount = count-1 }
                
                item.updateOnLike(
                    like: toggledLike,
                    count: newCount.intToKMString(),
                    previousCount: count.intToKMString()
                )
            }
            
            HStack {
                Image(systemName: "arrow.2.squarepath")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.secondary)
                
                CustomTransitioningCounterTextView(
                    count: item2.count,
                    previousCount: item2.previousCount
                )
                .id(item2.count)
            }
            .onTapGesture {
                let count: Int = item2.count.kmStringToInt() ?? 0
                let bool: Bool = .random()
                var newCount: Int = 0
                
                if bool { newCount = count+10 } else { newCount = count-1 }
                
                item2.updateOnLike(
                    count: newCount.intToKMString(),
                    previousCount: count.intToKMString()
                )
            }
        }
    }
}

// MARK: - Preview2
fileprivate struct Preview2: View {
    
    @State private var item: PreviewModel = .init(like: true, count: "100K")
    @State private var item2: PreviewModel = .init(count: "998K")
    
    var body: some View {
        HStack {
            HStack(spacing: -12) {
                CustomLikeHeartAnimationView(
                    like: item.like,
                    size: 55,
                    backgroundViewColor: .colorScheme
                )
                
                CustomTransitioningCounterTextView(
                    count: item.count,
                    previousCount: item.previousCount,
                    textColor: item.like ? .heartIconNText : .secondary
                )
                .id(item.count)
            }
            .onTapGesture {
                let count: Int = item.count.kmStringToInt() ?? 0
                let bool: Bool = .random()
                var newCount: Int = 0
                
                if bool { newCount = count+100 } else { newCount = count-1 }
                
                item.updateOnLike(
                    like: item.like,
                    count: newCount.intToKMString(),
                    previousCount: count.intToKMString()
                )
            }
            
            HStack {
                Image(systemName: "arrow.2.squarepath")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.secondary)
                
                CustomTransitioningCounterTextView(
                    count: item2.count,
                    previousCount: item2.previousCount
                )
                .id(item2.count)
            }
            .onTapGesture {
                let count: Int = item2.count.kmStringToInt() ?? 0
                let bool: Bool = .random()
                var newCount: Int = 0
                
                if bool { newCount = count+100 } else { newCount = count-1 }
                
                item2.updateOnLike(
                    count: newCount.intToKMString(),
                    previousCount: count.intToKMString()
                )
            }
        }
    }
}
