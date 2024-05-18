//
//  SavedListView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct SavedListView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    
    var body: some View {
        Text("Saved media")
    }
}

#Preview {
    SavedListView()
}
