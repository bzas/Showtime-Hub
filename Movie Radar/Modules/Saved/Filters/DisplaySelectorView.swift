//
//  DisplaySelectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct DisplaySelectorView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    @State private var triggerHapticFeedback = false

    var body: some View {
        VStack(spacing: 2) {
            Text("Display mode")
                .font(.system(size: 12, weight: .light))

            Menu {
                ForEach(GridDisplayMode.allCases, id: \.self) { displayMode in
                    Button(action: {
                        withAnimation {
                            viewModel.selectedDisplayMode = displayMode
                        }
                    }, label: {
                        Text(displayMode.title)
                    })
                }
            } label: {
                HStack(spacing: 5) {
                    Text(viewModel.selectedDisplayMode.title)
                    Image(systemName: "chevron.down")
                }
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 0.5),
                trigger: viewModel.selectedDisplayMode
            )
            .tint(.white)
            .font(.system(size: 14, weight: .semibold))
            .animation(
                .spring(duration: 0.3, bounce: 0),
                value: viewModel.selectedDisplayMode
            )
            .onTapGesture {
                triggerHapticFeedback.toggle()
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 1),
                trigger: triggerHapticFeedback
            )
        }
    }
}

#Preview {
    SortSelectorView()
}
