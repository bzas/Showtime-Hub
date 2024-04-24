//
//  FavoritesView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct FavoritesView: View {
    @State var viewModel: ViewModel

    var body: some View {
        Text("Favorites")
    }
}

#Preview {
    FavoritesView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
