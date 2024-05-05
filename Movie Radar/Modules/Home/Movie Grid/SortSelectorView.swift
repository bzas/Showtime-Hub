//
//  SortSelectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct SortSelectorView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel

    var body: some View {
        HStack {
            Text("Sort by:")
                .font(.system(size: 12, weight: .light))

            Menu(viewModel.sortType.title) {
                ForEach(GridSortType.allCases, id: \.self) { type in
                    Button(action: {
                        withAnimation {
                            viewModel.sortType = type
                        }
                    }, label: {
                        Text(type.title)
                    })
                }
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.white)
            .padding(6)
            .frame(width: 120)
            .background(UIColor.systemGray5.color)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    SortSelectorView()
}
