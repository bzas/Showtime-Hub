//
//  EditBackgroundView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/6/24.
//

import SwiftUI

struct EditBackgroundView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @State var listBackgroundType: ListBackground
    @State var listBackgroundIndex: Int
    @Binding var userList: UserList?
    
    init(userList: Binding<UserList?>) {
        self._userList = userList
        (listBackgroundType, listBackgroundIndex) = ListBackground.parse(path: userList.wrappedValue?.backgroundPath)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    userList?.backgroundPath = listBackgroundType.imagePath(index: listBackgroundIndex)
                    dismiss()
                }
                .foregroundStyle(appGradient.value)
            }
            .padding(.bottom)
            
            Spacer()
            
            BackgroundPickerView(
                listBackgroundType: $listBackgroundType,
                listBackgroundIndex: $listBackgroundIndex
            )
        }
        .padding()
        .presentationDetents([.height(300)])
    }
}
