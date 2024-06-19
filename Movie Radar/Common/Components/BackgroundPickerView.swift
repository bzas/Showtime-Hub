//
//  BackgroundPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/6/24.
//

import SwiftUI

struct BackgroundPickerView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @Binding var listBackgroundType: ListBackground
    @Binding var listBackgroundIndex: Int
    
    var body: some View {
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
    }
}
