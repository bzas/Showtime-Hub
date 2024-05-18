//
//  MediaPickerItemView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct MediaPickerItemView: View {
    var mediaType: MediaType
    @Binding var selectedMediaType: MediaType
    
    var body: some View {
        Text(mediaType.title)
            .padding(8)
            .padding(.horizontal, 6)
            .border(.white)
            .foregroundStyle(selectedMediaType == mediaType ? .black : .white)
            .background(selectedMediaType == mediaType ? .white : .black)
            .onTapGesture {
                withAnimation {
                    selectedMediaType = mediaType
                }
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 1),
                trigger: selectedMediaType
            )
    }
}
