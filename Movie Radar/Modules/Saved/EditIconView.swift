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
    @State var newCustomImage: UIImage?
    @State var selectedIconType: ListIconType

    init(userList: Binding<UserList?>) {
        self._userList = userList
        if let emojiValue = userList.wrappedValue?.emoji {
            self.newIconEmoji = Emoji(value: emojiValue, name: "")
        }
        self.newIconName = userList.wrappedValue?.imageName ?? ""
        self.newIconColor = userList.wrappedValue?.colorInfo?.color ?? .white
        if let imageData = userList.wrappedValue?.customImage {
            self.newCustomImage = UIImage(data: imageData)
        }
        
        if userList.wrappedValue?.emoji != nil {
            self.selectedIconType = .emoji
        } else if userList.wrappedValue?.imageName?.isEmpty == false {
            self.selectedIconType = .systemSymbol
        } else if userList.wrappedValue?.customImage != nil {
            self.selectedIconType = .upload
        } else {
            self.selectedIconType = .emoji
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    save()
                }
                .foregroundStyle(appGradient.value)
            }
            .padding(.bottom)
            
            Spacer()
            
            IconPickerView(
                listIcon: $newIconName,
                listColor: $newIconColor, 
                listEmoji: $newIconEmoji,
                selectedIconType: $selectedIconType, 
                customImage: $newCustomImage
            )
        }
        .padding()
        .presentationDetents([.height(300)])
    }
    
    func save() {
        switch selectedIconType {
        case .emoji:
            userList?.emoji = newIconEmoji?.value
            userList?.imageName = nil
            userList?.colorInfo = nil
            userList?.customImage = nil
        case .systemSymbol:
            userList?.emoji = nil
            userList?.imageName = newIconName
            userList?.colorInfo = .init(color: newIconColor)
            userList?.customImage = nil
        case .upload:
            userList?.emoji = nil
            userList?.imageName = nil
            userList?.colorInfo = nil
            userList?.customImage = newCustomImage?.pngData()
        }
        
        userList = nil
        dismiss()
    }
}
