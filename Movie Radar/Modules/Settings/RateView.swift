//
//  RateView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/5/24.
//

import SwiftUI

struct RateView: View {
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Button {
            requestReview()
        } label: {
            HStack {
                Text("Rate on the App Store")
                Spacer()
                Image("appStoreLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
