//
//  SaveMediaButtonView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI

struct SaveMediaButtonView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    var userList: UserList
    var isSaved: Bool
    
    var body: some View {
        Image(systemName: userList.imageName ?? "")
            .resizable()
            .scaledToFit()
            .foregroundStyle(isSaved ? userList.colorInfo?.color ?? .black.opacity(0.5) : .black.opacity(0.5))
            .frame(width: 20, height: 20)
            .padding(.horizontal, 2)
    }
}
