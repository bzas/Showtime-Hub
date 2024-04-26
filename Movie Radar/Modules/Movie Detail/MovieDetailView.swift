//
//  MovieDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct MovieDetailView: View {
    @State var viewModel: ViewModel

    var body: some View {
        Text("Movie detail")
            .presentationDetents([.medium, .large])
    }
}

#Preview {
    MovieDetailView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
