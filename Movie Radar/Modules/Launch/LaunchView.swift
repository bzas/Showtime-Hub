//
//  LaunchView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/6/24.
//

import SwiftUI

struct LaunchView: View {
    @Binding var show: Bool
    
    @State var backgroundOpacity = 1.0
    @State var imageScale = CGSize(
        width: 1,
        height: 1
    )
    
    @State var titleOpacity = 1.0
    @State var titleScale = CGSize(
        width: 1,
        height: 1
    )
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [UIColor.systemGray4.color, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(backgroundOpacity)
            
            VStack {
                Image("launchLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                    .scaleEffect(imageScale)
                Image("appLogo")
                    .resizable()
                    .frame(height: 50)
                    .scaledToFit()
                    .scaleEffect(titleScale)
                    .opacity(titleOpacity)
                    .padding(.horizontal, 50)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 750_000_000)
                
                withAnimation(.linear(duration: 0.25)) {
                    titleScale = .init(
                        width: 0,
                        height: 0
                    )
                } completion: {
                    titleOpacity = 0
                }
                
                withAnimation(.linear(duration: 1)) {
                    backgroundOpacity = 0
                    imageScale = .init(
                        width: 50,
                        height: 50
                    )
                } completion: {
                    show = false
                }
            }
        }
    }
}

