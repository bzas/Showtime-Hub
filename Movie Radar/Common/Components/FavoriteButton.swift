//
//  FavoriteButton.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct FavoriteButton: View {
    var action: () -> Void
    var body: some View {
        Button(
            action: action,
            label: {
            Image(systemName: "heart")
                    .foregroundStyle(LinearGradient.appGradient)
                    .frame(width: 25, height: 25)
        })
        .shadow(radius: 2)
    }
}
