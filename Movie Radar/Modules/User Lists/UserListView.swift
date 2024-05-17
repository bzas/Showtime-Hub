//
//  UserListView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        Text("Favorites")
    }
}

#Preview {
    UserListView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
