//
//  GenreSelectorCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GenreSelectorCellView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: HomeGridView.ViewModel
    var genre: Genre
    
    let grayGradient = LinearGradient(
        colors: [UIColor.systemGray5.color],
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        Button {
            viewModel.selectGenre(genre: genre)
        } label: {
            Text(genre.name)
                .font(.system(size: 14))
                .animation(.default)
                .padding(.horizontal)
                .frame(height: 30)
                .foregroundStyle(viewModel.isSelected(genre: genre) ? .black : .white)
                .background(viewModel.isSelected(genre: genre) ? appGradient.value : grayGradient)
                .clipShape(Capsule())
        }
    }
}
