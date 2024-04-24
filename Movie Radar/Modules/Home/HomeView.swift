//
//  HomeView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: ViewModel

    var body: some View {
        Text("Home")
    }
}

#Preview {
    HomeView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
