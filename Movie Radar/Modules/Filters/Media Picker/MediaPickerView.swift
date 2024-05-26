//
//  MediaPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct MediaPickerView: View {
    @Binding var selectedMediaType: MediaType

    var body: some View {
        HStack(spacing: 12) {
            Text("Content type")
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(MediaType.allCases, id: \.self) { mediaType in
                    MediaPickerItemView(
                        mediaType: mediaType,
                        selectedMediaType: $selectedMediaType
                    )
                }
            }
        }
    }
}
