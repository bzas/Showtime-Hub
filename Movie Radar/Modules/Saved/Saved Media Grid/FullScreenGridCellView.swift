//
//  FullScreenGridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct FullScreenGridCellView: View {
    @State var media: Media

    var body: some View {
        Text(media.publicName)
    }
}
