//
//  UserListsView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 31/5/24.
//

import SwiftUI
import SwiftData

struct UserListsView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.clear, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(viewModel.showGradient ? 1 : 0)
            
            TabView(selection: $viewModel.tabIndex) {
                ListsView()
                    .environmentObject(viewModel)
                    .tag(0)
                
                CreateListView()
                    .environmentObject(viewModel)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.top, 25)
            
            VStack {
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .padding(12)
                    })
                    Spacer()
                }
                Spacer()
            }
        }
        .transition(
            .asymmetric(
                insertion: .scale(scale: 0.01),
                removal: .scale(scale: 0.01)
            )
        )
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 250_000_000)
                withAnimation(.spring(duration: 0.75)) {
                    viewModel.showGradient.toggle()
                }
            }
        }
    }
}
