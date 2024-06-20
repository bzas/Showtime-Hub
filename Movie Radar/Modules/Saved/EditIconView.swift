//
//  EditIconView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import SwiftUI

struct EditIconView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @Binding var userList: UserList?
    @State var newIconName: String
    @State var newIconColor: Color
    @State var isSelectingNewIcon = false
    
    init(userList: Binding<UserList?>) {
        self._userList = userList
        self.newIconName = userList.wrappedValue?.imageName ?? ""
        self.newIconColor = userList.wrappedValue?.colorInfo?.color ?? .white
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    userList?.imageName = newIconName
                    userList?.colorInfo = .init(color: newIconColor)
                    userList = nil
                    dismiss()
                }
                .foregroundStyle(appGradient.value)
            }
            .padding(.bottom)
            
            Spacer()
            
            IconPickerView(
                isSelectingNewIcon: $isSelectingNewIcon,
                listIcon: $newIconName,
                listColor: $newIconColor
            )
        }
        .padding()
        .presentationDetents([.height(300)])
    }
}
