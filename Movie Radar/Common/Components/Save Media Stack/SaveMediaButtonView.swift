//
//  SaveMediaButtonView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI

struct SaveMediaButtonView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    var type: SavedType
    var isSaved: Bool
    
    var body: some View {
        Image(systemName: type.fillImageName)
            .foregroundStyle(isSaved ? type.color : .white)
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        .white,
                        lineWidth: 1
                    )
                    .fill(isSaved ? .white : .clear)
                    .padding(2)
            )
            .shadow(radius: 1)
    }
}

#Preview {
    SaveMediaButtonView(
        type: .favorites,
        isSaved: true
    )
}
