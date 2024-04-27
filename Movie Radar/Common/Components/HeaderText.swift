//
//  HeaderText.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct HeaderText: View {
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 25, weight: .light))
                .foregroundStyle(
                    LinearGradient.appGradient
                )
            Spacer()
        }
    }
}

#Preview {
    HeaderText(text: "Test")
}
