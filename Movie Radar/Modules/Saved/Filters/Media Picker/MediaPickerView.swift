//
//  MediaPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct MediaPickerView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel

    var body: some View {
        HStack(spacing: 0) {
            MediaPickerItemView(
                mediaType: .all,
                selectedMediaType: $viewModel.selectedPickerItem
            )
            
            MediaPickerItemView(
                mediaType: .movie,
                selectedMediaType: $viewModel.selectedPickerItem
            )
            
            MediaPickerItemView(
                mediaType: .tv,
                selectedMediaType: $viewModel.selectedPickerItem
            )
        }
    }
}

#Preview {
    MediaPickerView()
}
