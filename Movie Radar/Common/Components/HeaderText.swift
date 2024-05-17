//
//  HeaderText.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct HeaderText: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .lineLimit(2)
                .font(.system(size: 25, weight: .light))
                .foregroundStyle(appGradient.value)
            Spacer()
        }
    }
}

#Preview {
    HeaderText(text: "Test")
}
