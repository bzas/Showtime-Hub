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
    @State var selectedIconType = ListIconType.systemSymbol
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $selectedIconType) {
                ForEach(ListIconType.allCases, id: \.self) { iconType in
                    Text(iconType.title)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            switch selectedIconType {
            case .emoji:
                HStack {
                    Text("Emoji")
                    Spacer()
                    Button {
                        isSelectingNewEmoji.toggle()
                    } label: {
                        if let emoji = listEmoji?.value {
                            Text(emoji)
                                .font(.system(size: 30))
                        } else {
                            UIColor.systemGray4.color
                                .frame(
                                    width: 40,
                                    height: 40
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding()
                .padding(.trailing, 2)
            case .systemSymbol:
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
                .navigationTitle("Pick a list emoji")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
