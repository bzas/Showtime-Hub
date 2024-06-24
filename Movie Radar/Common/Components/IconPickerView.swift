//
//  IconPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import SwiftUI
import SFSymbolsPicker
import EmojiPicker
import PhotosUI

struct IconPickerView: View {
    @Binding var listIcon: String
    @Binding var listColor: Color
    @Binding var listEmoji: Emoji?
    @Binding var selectedIconType: ListIconType
    @Binding var customImage: UIImage?

    @State var isSelectingNewIcon = false
    @State var isSelectingNewEmoji = false
    
    @State private var imageItem: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $selectedIconType) {
                ForEach(ListIconType.allCases, id: \.self) { iconType in
                    Text(iconType.title)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 12)
            
            switch selectedIconType {
            case .emoji:
                HStack {
                    Text("Emoji")
                    Spacer()
                    Button {
                        isSelectingNewEmoji.toggle()
                    } label: {
                        ZStack {
                            UIColor.systemGray3.color
                                .frame(
                                    width: 45,
                                    height: 45
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            if let emoji = listEmoji?.value {
                                Text(emoji)
                                    .font(.system(size: 30))
                            }
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            case .systemSymbol:
                VStack(spacing: 0) {
                    HStack {
                        Text("System icon")
                        Spacer()
                        Button {
                            isSelectingNewIcon.toggle()
                        } label: {
                            Image(systemName: listIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 25, maxHeight: 25)
                                .clipped()
                                .frame(width: 45, height: 45)
                                .background(UIColor.systemGray3.color)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    }
                    .padding()
                    .padding(.trailing, 2)
                    
                    Color.gray
                        .opacity(0.2)
                        .frame(height: 1)
                    
                    ColorPicker(
                        "Color",
                        selection: $listColor
                    )
                    .frame(height: 45)
                    .padding()
                    .padding(.trailing, 10)
                }
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            case .upload:
                HStack {
                    Text("Upload image")
                    Spacer()
                    PhotosPicker(selection: $imageItem, matching: .images) {
                        if let customImage {
                            Image(uiImage: customImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            UIColor.systemGray3.color
                        }
                    }
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .onChange(of: imageItem) {
                    Task {
                        if let imageData = try? await imageItem?.loadTransferable(type: Data.self) {
                            customImage = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .sheet(isPresented: $isSelectingNewIcon) {
            SymbolsPicker(
                selection: $listIcon,
                title: "Pick a list icon",
                autoDismiss: true
            )
        }
        .sheet(isPresented: $isSelectingNewEmoji) {
            NavigationView {
                EmojiPickerView(
                    selectedEmoji: $listEmoji,
                    selectedColor: .white
                )
                .navigationTitle("Pick an emoji")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
