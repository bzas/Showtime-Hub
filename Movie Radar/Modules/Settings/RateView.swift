//
//  RateView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/5/24.
//

import SwiftUI

struct RateView: View {
    var body: some View {
        Link(destination: URL(string: "https://apps.apple.com/es/app/showtime-hub-cine-y-series/id6503365201")!) {
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
    }
}
