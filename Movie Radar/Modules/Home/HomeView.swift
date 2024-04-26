//
//  HomeView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: ViewModel

    @State private var show = false

    var body: some View {
        VStack {
            MovieCarouselView(viewModel: .init(apiService: viewModel.apiService))

            Button(action: {
                show.toggle()
            }, label: {
                Text("Button")
            })
            Spacer()
        }
        .sheet(isPresented: $show) {
            MovieDetailView(viewModel: .init(apiService: viewModel.apiService))
        }
    }
}

#Preview {
    HomeView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
