//
//  PersonCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/7/24.
//

import SwiftUI

struct PersonCellView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var person: Person
    @State var opacity = 0.0

    init(person: Person) {
        self.person = person
        imageLoader = .init(
            key: person.mediaKey,
            url: person.imageUrl
        )
    }
    
    var body: some View {
        HStack(spacing: 16) {
            buildImage()
            VStack {
                HStack {
                    Text(person.name ?? "")
                        .font(.system(size: 14))
                        .shadow(radius: 2)
                    Spacer()
                }
                if let role = person.role {
                    HStack {
                        Text(role.title)
                            .foregroundStyle(.black)
                            .font(.system(size: 12))
                            .padding(2)
                            .padding(.horizontal, 2)
                            .background(.white.opacity(0.5))
                            .clipShape(Capsule())
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .opacity(opacity)
        .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.5)
                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                .blur(radius: phase.isIdentity ? 0 : 1)
        }
        .onAppear {
            makeCellVisible()
        }
    }
    
    @ViewBuilder
    func buildImage() -> some View {
        if let posterImage = imageLoader.image {
            posterImage
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)
        } else {
            PlaceholderView()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
        }
    }
    
    func makeCellVisible() {
        Task {
            withAnimation(.linear(duration: 0.5)) {
                opacity = 1
            }
        }
    }
}
