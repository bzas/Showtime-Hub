//
//  MediaCrewCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 17/5/24.
//

import SwiftUI

struct MediaCrewCellView: View {
    @State var name: String?
    @State var role: String?
    @State var image: URL?

    var body: some View {
        HStack(spacing: 18) {
            AsyncImage(url: image) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: 75, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack {
                HStack {
                    Text(name ?? "")
                        .font(.system(size: 18))
                    Spacer()
                }

                HStack {
                    Text(role ?? "")
                        .font(.system(size: 14, weight: .light))
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.bottom)
    }
}

#Preview {
    MediaCrewCellView()
}
