//
//  Profile_SettingsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-17.
//

import SwiftUI

struct Profile_SettingsView: View {
    // MARK: - PROPERTIES
    @State private var isPresented: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 25) {
                topNavLinks
                Divider()
                bottomButtons
            }
            .font(.callout)
            .padding(.top)
        }
        .sheet(isPresented: $isPresented) {
            Profile_SwitchProfilesSheetView(isPresented: $isPresented)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Settings")
    }
}

// MARK: - PREVIEWS
#Preview("Profile_SettingsView") {
    NavigationStack {
        Profile_SettingsView()
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Profile_SettingsView {
    // MARK: - topNavLinks
    private var topNavLinks: some View {
        Group {
            NavLinkLabelView(
                iconName: "person.badge.plus",
                label: "Follow and invite friends") { Color.debug }
            
            NavLinkLabelView(
                iconName: "bell",
                label: "Notifications") { Color.debug }
            
            NavLinkLabelView(
                iconName: "lock",
                label: "Privacy") { Color.debug }
            
            NavLinkLabelView(
                iconName: "person.crop.circle",
                label: "Account") { Color.debug }
            
            NavLinkLabelView(
                iconName: "questionmark.circle",
                label: "Help") { Color.debug }
            
            NavLinkLabelView(
                iconName: "info.circle",
                label: "About") { Color.debug }
        }
        .padding(.horizontal)
    }
    
    // MARK: - bottomButtons
    private var bottomButtons: some View {
        Group {
            Button("Switch profiles") { isPresented = true }
                .tint(.accent)
            
            Button("Log out") { }
                .tint(.red)
        }
        .padding(.horizontal)
    }
}

// MARK: - SUBVIEWS

// MARK: - NavLinkLabelView
fileprivate struct NavLinkLabelView<T: View>: View {
    // MARK: - PROPERTIES
    let iconName: String
    let label: String
    let destination: T
    
    let iconSize: CGFloat = 22
    
    // MARK: - INITIALIZER
    init(iconName: String, label: String, @ViewBuilder destination: () -> T) {
        self.iconName = iconName
        self.label = label
        self.destination = destination()
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            destination
        } label: {
            
            HStack(spacing: 12) {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                
                Text(label)
            }
        }
        .tint(.primary)
    }
}
