//
//  BackgroundPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/6/24.
//

import SwiftUI
import PhotosUI

struct BackgroundPickerView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @Binding var listBackgroundType: ListBackground
    @Binding var listBackgroundIndex: Int
    @Binding var listBackgroundGenericType: ListBackgroundGenericType
    @Binding var customImage: UIImage?
    @State private var imageItem: PhotosPickerItem?
    
    var body: some View {
        switch listBackgroundGenericType {
        case .app:
            VStack {
                Picker("", selection: $listBackgroundType) {
                    ForEach(ListBackground.allCases, id: \.self) { backgroundType in
                        Text(backgroundType.title)
                    }
                }
                .pickerStyle(.segmented)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(Array(listBackgroundType.pathItems.enumerated()), id: \.1.self) { index, imagePath in
                            let isSelected = listBackgroundIndex == index
                            Image(imagePath)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(6)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.clear)
                                        .stroke(
                                            appGradient.value.opacity(0.5),
                                            lineWidth: isSelected ? 1 : 0
                                        )
                                )
                                .onTapGesture {
                                    listBackgroundIndex = index
                                }
                                .padding(.vertical, 8)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        case .upload:
            PhotosPicker(selection: $imageItem, matching: .images) {
                if let customImage {
                    Image(uiImage: customImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    UIColor.systemGray3.color
                        .overlay {
                            Text("Pick an image")
                                .foregroundStyle(.gray)
                                .disabled(true)
                                .multilineTextAlignment(.center)
                        }
                }
            }
            .frame(width: 150, height: 225)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: imageItem) {
                Task {
                    if let imageData = try? await imageItem?.loadTransferable(type: Data.self) {
                        customImage = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
