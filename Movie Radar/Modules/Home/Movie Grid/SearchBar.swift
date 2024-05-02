//
//  SearchBar.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    @FocusState private var isEditing: Bool

    var body: some View {
        HStack {
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isEditing)

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                }, label: {
                    Text("Cancel")
                })
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 12)
    }
}
