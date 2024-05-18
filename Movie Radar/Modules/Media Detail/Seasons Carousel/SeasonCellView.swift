//
//  SeasonCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct SeasonCellView: View {
    var season: Season
    
    var body: some View {
        VStack {
            AsyncImage(url: season.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: 133, height: 200)
            .clipped()
            
            HStack {
                Text(season.name ?? "")
                    .font(.system(size: 12, weight: .light))
                Spacer()
            }
        }
    }
}
