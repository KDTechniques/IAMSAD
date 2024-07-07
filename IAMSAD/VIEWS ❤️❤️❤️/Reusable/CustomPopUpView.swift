//
//  CustomPopUpView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-04.
//

import SwiftUI
import PopupView

struct CustomPopUpView: View {
    // MARK: - PROPERTIES
    @Binding var isPresented: Bool
    let leadingContentType: PopupLeadingContentTypes?
    let trailingButtonType: PopupTrailingButtonTypes?
    let text: String
    
    let contentSize: CGFloat = 30
    
    //  MARK: - INITIALIZER
    init(
        isPresented: Binding<Bool>,
        leadingContentType: PopupLeadingContentTypes? = nil,
        trailingButtonType: PopupTrailingButtonTypes? = nil,
        text: String
    ) {
        _isPresented = isPresented
        self.leadingContentType = leadingContentType
        self.trailingButtonType = trailingButtonType
        self.text = text
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            leadingContent
            
            middleContent
            
            Spacer()
            
            trailingButton
        }
        .frameViewModifier
    }
}

// MARK: - PREVIEWS
#Preview("CustomPopUpView - Icon") {
    @Previewable @State var isPresented: Bool = false
    
    Button("Toggle") { isPresented.toggle() }
        .popup(isPresented: $isPresented, view: {
            CustomPopUpView(
                isPresented: $isPresented,
                leadingContentType: .icon(systemName: "wifi", color: .green),
                text: "Your internet connection has been restored."
            )
            .frame(maxHeight: .infinity, alignment: .top)
        }, customize: {
            $0.appearFrom(.topSlide)
                .animation(.smooth)
                .autohideIn(5)
        })
        .previewViewModifier
}

#Preview("CustomPopUpView - Image+close") {
    Color.clear
        .safeAreaInset(edge: .top) {
            CustomPopUpView(
                isPresented: .constant(true),
                leadingContentType: .image(name: "LogoLight"),
                trailingButtonType: .action(label: "View", action: { }),
                text: UUID().uuidString+UUID().uuidString+UUID().uuidString
            )
        }
        .previewViewModifier
}

#Preview("CustomPopUpView - progress+action") {
    Color.clear
        .safeAreaInset(edge: .top) {
            CustomPopUpView(
                isPresented: .constant(true),
                leadingContentType: .progress,
                trailingButtonType: .action(label: "View", action: { }),
                text: "Posting..."
            )
        }
        .previewViewModifier
}

#Preview("CustomPopUpView - icon+navigation") {
    NavigationStack {
        Color.clear
            .safeAreaInset(edge: .top) {
                CustomPopUpView(
                    isPresented: .constant(true),
                    leadingContentType: .icon(systemName: "bookmark.fill", color: .accent),
                    trailingButtonType: .navigation(
                        label: "View",
                        destination: AnyView(Color.debug.ignoresSafeArea())
                    ),
                    text: "Added to bookmarks"
                )
            }
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomPopUpView {
    // MARK: - leadingContent
    private var leadingContent: some View {
        Group {
            if let leadingContentType {
                switch leadingContentType {
                case .progress:
                    ProgressView()
                    
                case .icon(let name, let color):
                    let size: CGFloat = contentSize - 5
                    Image(systemName: name)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(color)
                        .frame(width: size, height: size)
                    
                case .image(let name):
                    Image(name)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .frame(width: contentSize, height: contentSize) // must be less than popup frame height
    }
    
    // MRAK: - middleContent
    private var middleContent: some View {
        Text(text)
            .font(.subheadline)
            .minimumScaleFactor(0.8)
            .padding(.vertical, 5)
            .padding(.trailing)
    }
    
    // MARK: - trailingButton
    private var trailingButton: some View {
        Group {
            if let trailingButtonType {
                switch trailingButtonType {
                case .action(let label, let action):
                    Button {
                        action()
                    } label: { Text(label).font(.subheadline.weight(.medium)) }
                    
                case .navigation(let label, let destination):
                    NavigationLink {
                        destination
                    } label: { Text(label).font(.subheadline.weight(.medium)) }
                }
            }
        }
        .frame(height: contentSize)
    }
}

extension View {
    // MARK: - frameViewModifier
    fileprivate var frameViewModifier: some View {
        self
            .padding(.horizontal, 12)
            .frame(height: 55)
            .background(Color.accent.opacity(0.01))
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.accent, lineWidth: 0.5)
            )
            .padding(.horizontal, 8)
    }
}

// MARK: - OTHER

// MARK: - PopupLeadingContentTypes
enum PopupLeadingContentTypes {
    case icon(systemName: String, color: Color)
    case image(name: String)
    case progress
}

// MARK: - PopupTrailingContentTypes
enum PopupTrailingButtonTypes {
    case navigation(label: String, destination: AnyView)
    case action(label: String, action: () -> Void)
}
