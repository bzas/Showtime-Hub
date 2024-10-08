//
//  SocialNetworkCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct LinksCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Links")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            let links = LinkType.allCases.compactMap {
                MovieLink(
                    type: $0,
                    url: viewModel.linkList?.link(type: $0)
                )
            }
            if links.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No links available", comment: ""))
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 25) {
                        ForEach(links, id: \.self) { link in
                            LinksCarouselCellView(link: link)
                        }
                    }
                }
            }
        }
        .padding(.vertical)
    }
}
