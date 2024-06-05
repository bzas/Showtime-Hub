//
//  ProviderCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/6/24.
//

import SwiftUI

struct ProviderCarouselCellView: View {
    let imagePath: String
    
    var body: some View {
        Image(imagePath)
            .resizable()
            .scaledToFill()
            .frame(
                width: 50,
                height: 50
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
