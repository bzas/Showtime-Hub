//
//  GenreSelectorCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GenreSelectorCellView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .bluePurple
    @EnvironmentObject var viewModel: HomeMoviesView.ViewModel
    var genre: Genre

    var body: some View {
        Text(genre.name)
            .font(.system(size: 14))
            .foregroundStyle(viewModel.isSelected(genre: genre) ? Color.black : .gray)
            .animation(.default)
            .padding(.horizontal)
            .frame(height: 30)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        appGradient.value,
                        lineWidth: 1.5
                    )
                    .fill(.clear)
                    .if(viewModel.isSelected(genre: genre)) { view in
                        view.fill(appGradient.value)
                    }
                    .padding(2)
            )
            .onTapGesture {
                viewModel.selectGenre(genre: genre)
            }
    }
}

#Preview {
    GenreSelectorCellView(
        genre: Genre(
            id: 1,
            name: "Action"
        )
    )
}
