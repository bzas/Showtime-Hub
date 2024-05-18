//
//  SavedMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct SavedMediaGridView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    var type: SavedType
    
    let fullScreenColumns = [
        GridItem(.flexible())
    ]
    
    let listColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        let items = viewModel.items(type: type)
        if items.isEmpty {
            VStack {
                Text("No items saved yet")
                    .foregroundStyle(.gray)
                    .padding()
                Spacer()
            }
        } else {
            let columns = viewModel.selectedDisplayMode == .list ? listColumns : fullScreenColumns
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(items, id: \.self) { media in
                    switch viewModel.selectedDisplayMode {
                    case .list:
                        ListGridCellView(media: media)
                            .onTapGesture {
                                viewModel.detailMediaToShow = media
                            }
                            .contextMenu {
                                MediaContextMenu()
                            }
                    case .fullScreen:
                        FullScreenGridCellView()
                    }
                }
            }
        }
    }
}

#Preview {
    SavedMediaGridView(type: .favorites)
}
