//
//  GenreSelectorCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GenreSelectorCellView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    var genre: Genre

    var body: some View {
        Text(genre.name)
            .font(.system(size: 14))
            .foregroundStyle(viewModel.isSelected(genre: genre) ? UIColor.systemBackground.color : .gray)
            .animation(.default)
            .padding(.horizontal)
            .frame(height: 30)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient.appGradient,
                        lineWidth: 1.5
                    )
                    .fill(.clear)
                    .if(viewModel.isSelected(genre: genre)) { view in
                        view.fill(LinearGradient.appGradient)
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
