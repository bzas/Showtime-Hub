//
//  IconPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import SwiftUI
import SFSymbolsPicker
struct IconPickerView: View {
    @Binding var isSelectingNewIcon: Bool
    @Binding var listIcon: String
    @Binding var listColor: Color

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Icon")
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
        .sheet(isPresented: $isSelectingNewIcon) {
            SymbolsPicker(
                selection: $listIcon,
                title: "Pick a list icon",
                autoDismiss: true
            )
        }
    }
}
