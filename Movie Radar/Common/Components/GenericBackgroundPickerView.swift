//
//  GenericBackgroundPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/6/24.
//

import SwiftUI

struct GenericBackgroundPickerView: View {
    @Binding var listBackgroundGenericType: ListBackgroundGenericType
    
    var body: some View {
        Menu {
            ForEach(ListBackgroundGenericType.allCases, id: \.self) { bgType in
                Button {
                    listBackgroundGenericType = bgType
                } label: {
                    Label(
                        bgType.title,
                        systemImage: (listBackgroundGenericType == bgType) ? "checkmark" : ""
                    )
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(listBackgroundGenericType.title)
                    .font(.system(size: 14))
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 10, height: 6)
                    .scaledToFit()
                    .clipped()
            }
            .opacity(0.75)
        }
    }
}
