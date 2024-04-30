//
//  PlaceholderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

enum PlaceholderType {
    case movie,
         person

    var imageName: String {
        switch self {
        case .movie:
            return "movieclapper"
        case .person:
            return "person"
        }
    }
}

struct PlaceholderView: View {
    var type: PlaceholderType

    var body: some View {
        UIColor.systemGray5.color
            .overlay {
                Image(systemName: type.imageName)
                    .resizable()
                    .foregroundStyle(LinearGradient.appGradient)
                    .frame(width: 40, height: 40)
            }
    }
}

#Preview {
    PlaceholderView(type: .movie)
}
