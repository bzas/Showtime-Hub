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
    @State var listBackgroundGenericType: ListBackgroundGenericType
    @State var listBackgroundIndex: Int
    @State var newCustomBackground: UIImage?
    @Binding var userList: UserList?

    init(userList: Binding<UserList?>) {
        self._userList = userList
        (listBackgroundType, listBackgroundIndex) = ListBackground.parse(path: userList.wrappedValue?.backgroundPath)
        if let bgData = userList.wrappedValue?.customBackground {
            newCustomBackground = UIImage(data: bgData)
        }
        
        listBackgroundGenericType = (userList.wrappedValue?.customBackground != nil) ? .upload : .app
    }
    
    var body: some View {
        VStack {
            HStack {
                GenericBackgroundPickerView(listBackgroundGenericType: $listBackgroundGenericType)
                Spacer()
                Button("Save") {
                    save()
                }
                .foregroundStyle(appGradient.value)
            }
            .padding(.bottom)
            
            Spacer()
            
            BackgroundPickerView(
                listBackgroundType: $listBackgroundType,
                listBackgroundIndex: $listBackgroundIndex, 
                listBackgroundGenericType: $listBackgroundGenericType, 
                customImage: $newCustomBackground
            )
        }
        .padding()
        .presentationDetents([.height(375)])
    }
    
    func save() {
        Task {
            await userList?.updateBackground(
                selectedType: listBackgroundGenericType,
                newCustomBackground: newCustomBackground,
                listBackgroundType: listBackgroundType,
                listBackgroundIndex: listBackgroundIndex
            )
            await MainActor.run {
                userList = nil
            }
        }
        dismiss()
    }
}
