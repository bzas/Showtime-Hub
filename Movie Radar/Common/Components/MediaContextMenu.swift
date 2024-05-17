//
//  MediaContextMenu.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 17/5/24.
//

import SwiftUI

struct MediaContextMenu: View {
    var body: some View {
        Button {
            // Add to Favorites
        } label: {
            HStack {
                Image(systemName: "heart")
                Text("Add to Favorites")
            }
        }

        Button {
            // Add to viewed
        } label: {
            HStack {
                Image(systemName: "checkmark.square")
                Text("Mark as viewed")
            }
        }
    }
}

#Preview {
    MediaContextMenu()
}
