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
    
    var imageName: String {
        switch type {
        case .favorites:
            "heart.fill"
        case .viewed:
            "eye.fill"
        }
    }
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundStyle(isSaved ? LinearGradient.black : appGradient.value)
        .frame(width: 50, height: 50)
        .clipShape(Circle())
        .background(
            Circle()
                .stroke(
                    appGradient.value,
                    lineWidth: 1
                )
                .fill(isSaved ? appGradient.value : LinearGradient.clear)
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
