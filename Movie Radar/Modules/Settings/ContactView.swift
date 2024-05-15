//
//  ContactView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/5/24.
//

import SwiftUI

struct ContactView: View {
    @EnvironmentObject var viewModel: SettingsView.ViewModel

    var body: some View {
        Link(destination: URL(string: viewModel.contactMail)!) {
            HStack {
                Text("Contact us")
                Spacer()
                Image("atLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContactView()
}
