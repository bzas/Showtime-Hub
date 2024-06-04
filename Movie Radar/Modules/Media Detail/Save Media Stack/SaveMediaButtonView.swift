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
            .foregroundStyle(isSaved ? userList.colorInfo?.color ?? .white : .white)
            .frame(width: 45, height: 45)
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
