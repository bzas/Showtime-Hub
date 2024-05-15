//
//  NoDataAvailableView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct NoDataAvailableView: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .light))
            .padding(.bottom)
            .padding(.top, 4)
            .opacity(0.5)
    }
}

#Preview {
    NoDataAvailableView(title: "Test")
}
