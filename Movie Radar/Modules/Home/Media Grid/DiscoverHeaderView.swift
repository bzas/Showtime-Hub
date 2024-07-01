//
//  DiscoverHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/6/24.
//

import SwiftUI

struct DiscoverHeaderView: View {
    private let maxHeight = 300.0
    private let zoomCorrection = UIScreen.main.bounds.height / 4
    @State var imageZoom = 0.0
    
    var media: Media?
    @Binding var detailMediaToShow: Media?
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: media?.originalWideImageUrl,
                transaction: Transaction(
                    animation: .spring(duration: 1)
                )) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .transition(.opacity)
                    default:
                        PlaceholderView()
                    }
                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.width
                )
                .clipped()
                .scaleEffect(imageZoom)
            
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .clear, location: 0.7),
                    Gradient.Stop(color: Color.black, location: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named(AppCoordinateSpace.mediaDetail.rawValue)).origin
                        )
                }
            )
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                updateZoom(value.y)
            }
            .overlay {
                VStack(spacing: 12) {
                    Spacer()
                    Text(media?.name ?? "")
                        .font(.system(size: 20, weight: .light))
                        .shadow(radius: 2)
                        .shadow(radius: 2)
                    Text(media?.dateString ?? "")
                        .font(.system(size: 14, weight: .light))
                        .opacity(0.75)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .onTapGesture {
                detailMediaToShow = media
            }
    }
    
    func updateZoom(_ value: CGFloat) {
        var zoomToAdd = 0.0
        if value > 0 {
            zoomToAdd = value / zoomCorrection
        }
        
        imageZoom = 1 + zoomToAdd
    }
}
