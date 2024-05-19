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
    
    let clearGradient = LinearGradient(
        gradient: Gradient(colors: [.clear]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    let blackGradient = LinearGradient(
        gradient: Gradient(colors: [.black]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundStyle(isSaved ? blackGradient : appGradient.value)
        .frame(width: 50, height: 50)
        .clipShape(Circle())
        .background(
            Circle()
                .stroke(
                    appGradient.value,
                    lineWidth: 1
                )
                .fill(isSaved ? appGradient.value : clearGradient)
                .padding(2)
        )
    }
}

#Preview {
    SaveMediaButtonView(
        type: .favorites,
        isSaved: true
    )
}
