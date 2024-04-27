//
//  PlaceholderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        Color.clear
            .border(
                LinearGradient.appGradient,
                width: 1.5
            )
            .overlay {
                Image(systemName: "movieclapper")
                    .resizable()
                    .foregroundStyle(LinearGradient.appGradient)
                    .frame(width: 40, height: 40)
            }
    }
}

#Preview {
    PlaceholderView()
}
