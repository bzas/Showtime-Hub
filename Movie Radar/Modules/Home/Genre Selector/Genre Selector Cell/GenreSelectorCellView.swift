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
        ZStack {
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
            Text(genre.name)
                .font(.system(size: 14))
                .foregroundColor(viewModel.isSelected(genre: genre) ? UIColor.systemBackground.color : .gray)
                .padding(.horizontal)
        }
        .frame(height: 30)
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
