//
//  UserListsCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 31/5/24.
//

import SwiftUI

struct UserListsCellView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white

    var userList: UserList
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(userList.title ?? "")
            Spacer()
            if let imageName = userList.imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .stroke(
                    appGradient.value.opacity(0.5),
                    lineWidth: isSelected ? 1 : 0
                )
        )
    }
}
