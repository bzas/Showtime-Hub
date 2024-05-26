//
//  MediaPickerItemView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct MediaPickerItemView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white

    var mediaType: MediaType
    @Binding var selectedMediaType: MediaType
    
    let clearGradient = LinearGradient(
        gradient: Gradient(colors: [.clear]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        Text(mediaType.title)
            .font(
                .system(
                    size: 14,
                    weight: selectedMediaType == mediaType ? .semibold : .light
                )
            )
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .border(appGradient.value)
            .foregroundStyle(selectedMediaType == mediaType ? .black : .white)
            .background(selectedMediaType == mediaType ? appGradient.value : clearGradient)
            .onTapGesture {
                selectedMediaType = mediaType
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 1),
                trigger: selectedMediaType
            )
    }
}
