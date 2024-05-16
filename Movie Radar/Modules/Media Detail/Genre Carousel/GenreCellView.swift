//
//  GenreCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI

struct GenreCellView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .bluePurple
    var genre: Genre

    var body: some View {
        Text(genre.name)
            .font(.system(size: 14))
            .foregroundStyle(appGradient.value)
            .padding(.horizontal)
            .frame(height: 30)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        appGradient.value,
                        lineWidth: 1.5
                    )
                    .fill(.clear)
                    .padding(2)
            )
    }
}

#Preview {
    GenreCellView(
        genre: Genre(
            id: 1,
            name: "Action"
        )
    )
}
