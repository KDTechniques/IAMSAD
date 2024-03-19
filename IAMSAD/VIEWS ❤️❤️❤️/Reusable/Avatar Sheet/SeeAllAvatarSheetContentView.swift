//
//  SeeAllAvatarSheetContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-25.
//

import SwiftUI

struct SeeAllAvatarSheetContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedCollection: AvatarCollectionModel? = nil
    @State private var showRowBackground: Bool = false
    
    // MARK: BODY
    var body: some View {
        VStack {
            sheetHeadlineText
            scrollView
        }
        .padding(.top, 50)
        .presentationDragIndicator(.visible)
        .sheet(item: $selectedCollection) {
            AvatarCollectionSheetContentView(
                showRowBackground: $showRowBackground,
                item: $0
            )
        }
    }
}

// MARK: - PREVIEWS
#Preview("SeeAllAvatarSheetContentView") {
    Color.clear
        .sheet(isPresented: .constant(true)) { SeeAllAvatarSheetContentView() }
        .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
extension SeeAllAvatarSheetContentView {
    // MARK: - sheetHeadlineText
    private var sheetHeadlineText: some View {
        Text("Avatars")
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
    }
    
    // MARK: - collectionNameText
    private func collectionNameText(collectionName: AvatarCollectionTypes) -> some View {
        HStack {
            Text(collectionName.rawValue)
                .font(.headline)
            
            Spacer()
            
            Text("Selected")
                .foregroundStyle(.secondary)
                .font(.footnote)
                .opacity(
                    AvatarSheetVM
                        .shared
                        .selectedAvatar?
                        .collection == collectionName ? 1 : 0
                )
        }
    }
    
    // MARK: - handleTapGestures
    private func handleTapGestures(item: AvatarCollectionModel) {
        showRowBackground = true
        selectedCollection = item
    }
    
    // MARK: - checkSelectedCollection
    private func checkSelectedCollection(_ item: AvatarCollectionModel) -> Bool {
        selectedCollection == item && showRowBackground
    }
    
    // MARK: - setSelectedRowBackgroundColor
    private func setSelectedRowBackgroundColor(item: AvatarCollectionModel) -> UIColor {
        colorScheme == .dark
        ? (checkSelectedCollection(item)
           ? .systemGray4
           : .systemGray6
        )
        : (checkSelectedCollection(item)
           ? .systemGray4
           : .white
        )
    }
    
    // MARK: - listRow
    private var scrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(AvatarCollectionTypes.avatarCollectionsArray) { item in
                VStack(alignment: .leading) {
                    collectionNameText(collectionName: item.collectionName)
                    AvatarSheetCollectionRowView(collectionName: item.collectionName)
                }
                .padding(.horizontal)
                .padding(.top, 4)
                .padding(.bottom)
                .overlay(alignment: .bottom) { Divider().padding(.horizontal) }
                .background(
                    Color(uiColor: setSelectedRowBackgroundColor(item: item))
                )
                .onTapGesture { handleTapGestures(item: item) }
                .onLongPressGesture(minimumDuration: .zero) {
                    handleTapGestures(item: item)
                }
            }
        }
    }
}

// MARK: - SUBVIEWS
// MARK: - AvatarSheetCollectionRowView
fileprivate struct AvatarSheetCollectionRowView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatar: Avatar
    
    let collectionName: AvatarCollectionTypes
    
    // MARK: - INITILIZER
    init(collectionName: AvatarCollectionTypes) {
        self.collectionName = collectionName
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 10) {
            let avatarsArray: [AvatarModel] = Array(
                avatar
                    .publicAvatarsArray
                    .filter({ $0.collection == collectionName })
                    .prefix(6)
            )
            
            ForEach(avatarsArray) {
                CustomAvatarView(
                    avatar: $0,
                    color: Color(
                        hue: Double.random(in: 0...1),
                        saturation: 0.1,
                        brightness: 1
                    ),
                    withBorder: true
                )
            }
        }
    }
}

// MARK: - AvatarCollectionSheetContentView
fileprivate struct AvatarCollectionSheetContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    @Binding var showRowBackground: Bool
    let item: AvatarCollectionModel
    
    @State private var minY: CGFloat = 0
    @State private var maxY: CGFloat = 0
    @State private var showDivider: Bool = false
    let avatarColumns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            CollectionInfoView(item: item)
            
            Divider()
                .topPartBackgroundEffectOnScrollViewModifier(
                    minY: minY,
                    maxY: $maxY,
                    showBackgroundEffect: $showDivider
                )
                .opacity(showDivider ? 1 : 0)
            
            ScrollView(.vertical, showsIndicators: false) {
                AvatarListView(collection: item.collectionName)
                    .bottomPartBackgroundEffectOnScrollViewModifier(minY: $minY)
                    .padding(.vertical)
                    .padding(.bottom, 100)
            }
            .padding(.horizontal)
        }
        .presentationDragIndicator(.visible)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                showRowBackground = false
            }
        }
        .overlay(alignment: .bottom) { SheetBottomContentView() }
        .onChange(of: minY) { showDivider = maxY > $1 }
    }
}

// MARK: - AvatarListView
fileprivate struct AvatarListView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatar: Avatar
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    let collection: AvatarCollectionTypes
    
    let numberOfColumns: Int = 4
    
    // MARK: - INITIALIZER
    init(collection: AvatarCollectionTypes) { self.collection = collection }
    
    // MARK: - BODY
    var body: some View {
        let avatarsArray: [AvatarModel] = avatar
            .publicAvatarsArray
            .filter({ $0.collection == collection })
        
        let totalItems: Int = avatarsArray.count
        
        VStack(alignment: .leading) {
            ForEach(getVerticalRange(totalItems: totalItems), id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(getHorizontalRange(), id: \.self) { column in
                        let cellIndex: Int = getCellIndex(row: row, column: column) - 1
                        
                        if cellIndex < totalItems {
                            CustomSelectableAvatarView(
                                selectedAvatar: $avatarSheetVM.selectedAvatar,
                                dynamicColor: $avatarSheetVM.selectedBackgroundColor,
                                avatar: avatarsArray[cellIndex],
                                staticColor: Color(
                                    hue: avatarSheetVM.selectedBackgroundColor.hue,
                                    saturation: avatarSheetVM.selectedBackgroundColor.saturation,
                                    brightness: avatarSheetVM.selectedBackgroundColor.brightness
                                ),
                                isAutoColorOn: true
                            )
                        } else { Color.clear }
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarListView") {
    ScrollView(.vertical, showsIndicators: false) {
        AvatarListView(collection: .professions3)
            .padding()
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension AvatarListView {
    // MARK: - getCellIndex
    private func getCellIndex(row: Int, column: Int) -> Int {
        row * numberOfColumns + column + 1 - 1
    }
    
    // MARK: - getVerticalRange
    private func getVerticalRange(totalItems: Int) -> Range<Int> {
        0..<(totalItems / numberOfColumns) + (totalItems % numberOfColumns > 0 ? 1 : 0)
    }
    
    // MARK: - getHorizontalRange
    private func getHorizontalRange() -> ClosedRange<Int> { 1...numberOfColumns }
}


// MARK: - CollectionInfoView
fileprivate struct CollectionInfoView: View {
    // MARK: - PROPERTIES
    let item: AvatarCollectionModel
    
    // MARK: - INITIALIZER
    init(item: AvatarCollectionModel) { self.item = item }
    
    // MARK: -  BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.collectionName.rawValue)
                .font(.largeTitle.bold())
            
            Text(item.description)
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 50)
        .padding(.bottom, 8)
        .padding(.horizontal)
    }
}

// MARK: - SheetBottomContentView
fileprivate struct SheetBottomContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        let blurBackgroundHeight: CGFloat = 35
        let extraBlurBackgroundHeight: CGFloat = 50
        VStack {
            Text("Auto Color ON".uppercased())
                .font(.caption2.weight(.medium))
                .padding(5)
                .background(Color(uiColor: .systemGray5))
                .clipShape(.rect(cornerRadius: 5))
            
            Text("Tap repeatedly to change color")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .background(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
        .background(alignment: .top) {
            Rectangle()
                .fill(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
                .frame(height: blurBackgroundHeight)
                .blur(radius: 3)
                .offset(y: -blurBackgroundHeight/2)
        }
        .background(alignment: .top) {
            Rectangle()
                .fill(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
                .frame(height: blurBackgroundHeight+extraBlurBackgroundHeight)
                .blur(radius: 30)
                .offset(y: -(blurBackgroundHeight+extraBlurBackgroundHeight)/2)
        }
    }
}
