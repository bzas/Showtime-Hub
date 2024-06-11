//
//  GenreCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI

struct GenreCellView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    var genre: Genre

    var body: some View {
        Text(genre.name)
            .font(.system(size: 14, weight: .light))
            .foregroundStyle(appGradient.value)
            .padding(.horizontal)
            .frame(height: 30)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        appGradient.value,
                        lineWidth: 1
                    )
                    .fill(.clear)
                    .padding(2)
            )
    }
}
