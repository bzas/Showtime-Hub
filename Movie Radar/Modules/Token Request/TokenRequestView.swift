//
//  KeyRequestView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI

struct TokenRequestView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocused: Bool
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 25) {
            HeaderText(text: "Enter your token")
            VStack {
                TextField("Your authorization token", text: $viewModel.apiKey)
                    .font(.system(size: 14))
                    .padding()
                    .background(UIColor.systemGray5.color)
                    .cornerRadius(5)
                    .focused($isFocused)
                    .onTapGesture {
                        isFocused = true
                    }

                if let url = URL(string: PathBuilder.baseUrl) {
                    HStack {
                        Link(destination: url) {
                            HStack(spacing: 2) {
                                Image(systemName: "link.circle")
                                Text("Tap here to get a free one")
                            }
                        }
                        .foregroundStyle(.primary)
                        .fontWeight(.thin)
                        Spacer()
                    }
                }
            }

            Spacer()
            Button(action: {
                if viewModel.storeKey() {
                    dismiss()
                } else {
                    print("Error storing API Key")
                }
            }, label: {
                Text("Save")
                    .foregroundStyle(LinearGradient.appGradient)
                    .padding()
            })
            .disabled(viewModel.apiKey.isEmpty)
            .opacity(viewModel.apiKey.isEmpty ? 0.5 : 1)
        }
        .padding()
        .presentationDetents([.medium])
        .interactiveDismissDisabled()
    }
}

#Preview {
    TokenRequestView(viewModel: .init(apiService: APIServiceMock()))
}
