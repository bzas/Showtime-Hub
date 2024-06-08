//
//  Toast.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 7/6/24.
//

import SwiftUI

struct Toast: View {
    var toastInfo: ToastInfo
    @Binding var show: Bool
    
    var body: some View {
        HStack {
            Image(systemName: toastInfo.imageName)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(toastInfo.color)
            Text(toastInfo.text)
        }
        .padding()
        .background(UIColor.systemGray5.color)
        .clipShape(Capsule())
        .transition(
            .asymmetric(
                insertion: .scale(scale: 0.01),
                removal: .scale(scale: 0.01)
            )
        )
        .task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation(.spring(duration: 0.25)) {
                show = false
            }
        }
    }
}
