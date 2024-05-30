//
//  NoInternetPopUpView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/5/24.
//

import SwiftUI

struct NoInternetPopUpView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
                .resizable()
                .frame(width: 75, height: 75)
                .padding(.bottom)
            Text("No internet connection")
                .font(.system(size: 20))
            Text("Please make sure you are connected to the internet for being able to use the app")
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.black.opacity(0.75))
    }
}
