//
//  CustomStandardAccentBottomButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

// MARK: - For Primary Button Only
struct CustomStandardPrimaryBottomButtonView<T: View>: View {
    // MARK: - PROPERTIES
    let pText: String
    let showProgressIndicator: Bool
    let text: T
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(
        pText: String,
        showProgressIndicator: Bool = false,
        text: T = Color.clear,
        action: @escaping () -> Void
    ) {
        self.pText = pText
        self.showProgressIndicator = showProgressIndicator
        self.text = text
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // Primary Button
            Button {
                action()
            } label: {
                Text(pText.capitalized)
                    .standardAccentColorBottomButtonViewModifier(showProgressIndicator: showProgressIndicator)
            }
            
            // Secondary Button
            /// The secondary button is not visible.
            /// it's present solely to reserve space for alignment consistency.
            Button { } label: {
                Text("Sample Text".capitalized)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .opacity(0)
            }
            .disabled(true)
            .overlay { text }
            .padding(.top)
        }
        .padding(.bottom)
    }
}

// MARK: - For Both Primary & Secondary Buttons
struct CustomStandardPrimaryNSecondaryBottomButtonsView: View {
    // MARK: - PROPERTIES
    let pText: String
    let psText: String?
    let sText: String
    let showProgressIndicator: Bool
    let pAction: () -> Void
    let sAction: () -> Void
    
    // MARK: - INITIALIZER
    init(
        pText: String,
        psText: String? = nil,
        sText: String,
        showProgressIndicator: Bool = false,
        pAction: @escaping () -> Void,
        sAction: @escaping () -> Void
    ) {
        self.pText = pText
        self.psText = psText
        self.sText = sText
        self.showProgressIndicator = showProgressIndicator
        self.pAction = pAction
        self.sAction = sAction
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // Primary Button
            Button {
                pAction()
            } label: {
                if let psText = psText {
                    VStack {
                        Text("Sample Text".capitalized)
                            .opacity(0)
                            .standardAccentColorBottomButtonViewModifier(showProgressIndicator: showProgressIndicator)
                            .overlay {
                                VStack {
                                    Text(pText.capitalized)
                                        .font(.headline)
                                    
                                    Text(psText)
                                        .font(.footnote.weight(.medium))
                                }
                                .foregroundStyle(Color(uiColor: .tertiarySystemBackground))
                            }
                    }
                } else {
                    Text(pText.capitalized)
                        .standardAccentColorBottomButtonViewModifier(showProgressIndicator: showProgressIndicator)
                }
            }
            
            // Secondary Button
            Button {
                sAction()
            } label: {
                Text(sText.capitalized)
                    .font(.headline)
            }
            .padding(.top)
        }
        .padding(.bottom)
    }
}

// MARK: - For Secondary Button Only
struct CustomStandardSecondaryBottomButtonsView: View {
    // MARK: - PROPERTIES
    let sText: String
    let sAction: () -> Void
    
    // MARK: - INITIALIZER
    init(sText: String, sAction: @escaping () -> Void) {
        self.sText = sText
        self.sAction = sAction
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // Primary Button
            /// The primary button is not visible.
            /// it's present solely to reserve space for alignment consistency.
            Button { } label: {
                Text("Sample Text".capitalized)
                    .standardAccentColorBottomButtonViewModifier()
                    .opacity(0)
            }
            
            // Secondary Button
            Button {
                sAction()
            } label: {
                Text(sText.capitalized)
                    .font(.headline)
            }
            .padding(.top)
        }
        .padding(.bottom)
    }
}

// MARK: - For Primary Navigation Button Only
struct CustomStandardNavBottomButtonView<T: View>: View {
    // MARK: - PROPERTIES
    let text: String
    let content: T
    
    // MARK: - INITIALIZER
    init(text: String, @ViewBuilder content: () -> T) {
        self.text = text
        self.content = content()
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // Navigation Link
            NavigationLink {
                content
            } label: {
                Text(text.capitalized)
                    .standardAccentColorBottomButtonViewModifier()
            }
            
            // Secondary Button
            /// The secondary button is not visible.
            /// it's present solely to reserve space for alignment consistency.
            Button { } label: {
                Text("Sample Text".capitalized)
                    .font(.headline)
                    .opacity(0)
            }
            .disabled(true)
            .padding(.top)
        }
        .padding(.bottom)
    }
}

// MARK: - For Primary Gray/White Navigation Button Only
struct CustomStandardGrayWhiteNavBottomButtonView: View {
    // MARK: - PROPERTIES
    let text: String
    let content: AnyView
    let primaryButtonOverlayContent: AnyView?
    
    // MARK: - INITIALIZER
    init(
        text: String,
        content: AnyView,
        primaryButtonOverlayContent: AnyView? = nil
    ) {
        self.text = text
        self.content = content
        self.primaryButtonOverlayContent = primaryButtonOverlayContent
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            ZStack {
                NavigationLink {
                    content
                } label: {
                    Text(text.capitalized)
                        .standardNonPrimaryGrayWhiteBottomButtonViewModifier
                }
                
                primaryButtonOverlayContent
            }
            
            // Secondary Button
            /// The secondary button is not visible.
            /// it's present solely to reserve space for alignment consistency.
            Button { } label: {
                Text("Sample Text".capitalized)
                    .font(.headline)
                    .opacity(0)
            }
            .disabled(true)
            .padding(.top)
        }
        .padding(.bottom)
    }
}

// MARK: - PREVIEWS
#Preview("Primary Button Only") {
    VStack {
        Spacer()
        CustomStandardPrimaryBottomButtonView(
            pText: "continue",
            text:
                VStack {
                    Text("Recurring billing, cancel anytime.")
                    
                    Text("restore".capitalized)
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
        ) { }
    }
    .previewViewModifier
}

#Preview("Both Primary & Secondary Buttons") {
    VStack {
        Spacer()
        CustomStandardPrimaryNSecondaryBottomButtonsView(
            pText: "continue",
            psText: "1 month free, then $0.99/month",
            sText: "cancel"
        ) { } sAction: { }
    }
    .previewViewModifier
}

#Preview("Secondary Button Only") {
    VStack {
        Spacer()
        CustomStandardSecondaryBottomButtonsView(sText: "redeem code") { }
    }
    .previewViewModifier
}

#Preview("Primary Navigation Button Only") {
    NavigationStack {
        VStack {
            Spacer()
            CustomStandardNavBottomButtonView(text: "navigate") {
                Text("Hello, World!")
            }
        }
    }
    .previewViewModifier
}

#Preview("Primary Gray/White Navigation Button Only") {
    NavigationStack {
        VStack {
            Spacer()
            CustomStandardGrayWhiteNavBottomButtonView(
                text: "customize",
                content: AnyView(Text("Hello, World!"))
            )
        }
    }
    .previewViewModifier
}
