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
    @State var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(userList.title ?? "")
            Spacer()
            if let emoji = userList.emoji {
                Text(emoji)
                    .font(.system(size: 30))
                    .frame(height: 30)
            } else if let imageName = userList.imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(userList.colorInfo?.color ?? .white)
                    .padding(.trailing, 4)
                    .frame(height: 30)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(isSelected ? 6 : 0)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
                .stroke(
                    appGradient.value.opacity(0.5),
                    lineWidth: isSelected ? 2 : 0
                )
        )
        .padding(isSelected ? 2 : 0)
    }
}
