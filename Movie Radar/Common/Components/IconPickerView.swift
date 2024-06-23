//
//  IconPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import SwiftUI
import SFSymbolsPicker
import EmojiPicker

struct IconPickerView: View {
    @Binding var listIcon: String
    @Binding var listColor: Color
    @Binding var listEmoji: Emoji?

    @State var isSelectingNewIcon = false
    @State var isSelectingNewEmoji = false
    @State var selectedIconType = ListIconType.emoji
    
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
                    .padding()
                }
                .background(.ultraThinMaterial)
                .cornerRadius(10)
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
