//
//  ListGridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct ListGridCellView: View {
    @State var media: Media

    var body: some View {
        ZStack {
            AsyncImage(url: media.posterImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(height: 185)
            .clipped()
            
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.7),
                    .init(color: .black.opacity(0.5), location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack {
                Spacer()
                HStack {
                    Text(media.name)
                        .shadow(radius: 4)
                        .font(.system(size: 12))
                        .lineLimit(3)
                    Spacer()
                }
            }
            .padding(4)
        }
    }
}
