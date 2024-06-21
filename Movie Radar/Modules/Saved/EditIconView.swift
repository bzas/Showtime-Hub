//
//  EditIconView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import SwiftUI
import EmojiPicker

struct EditIconView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @Binding var userList: UserList?
    @State var newIconName: String
    @State var newIconColor: Color
    @State var newIconEmoji: Emoji?

    init(userList: Binding<UserList?>) {
        self._userList = userList
        self.newIconName = userList.wrappedValue?.imageName ?? "star.fill"
        self.newIconColor = userList.wrappedValue?.colorInfo?.color ?? .white
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    if let newIconEmoji {
                        userList?.emoji = newIconEmoji.value
                        userList?.imageName = nil
                        userList?.colorInfo = nil
                    } else {
                        userList?.emoji = nil
                        userList?.imageName = newIconName
                        userList?.colorInfo = .init(color: newIconColor)
                    }
                    userList = nil
                    dismiss()
                }
                .foregroundStyle(appGradient.value)
            }
            .padding(.bottom)
            
            Spacer()
            
            IconPickerView(
                listIcon: $newIconName,
                listColor: $newIconColor, 
                listEmoji: $newIconEmoji
            )
        }
        .padding()
        .presentationDetents([.height(300)])
    }
}
