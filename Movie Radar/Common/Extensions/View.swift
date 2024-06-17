//
//  View.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func customizeTabItem(name: String, imageName: String) -> some View {
        toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.black, for: .tabBar)
            .tabItem {
                Label(
                    name,
                    systemImage: imageName
                )
            }
    }
    
    func toast(show: Binding<Bool>, toastInfo: ToastInfo?) -> some View {
        overlay {
            if show.wrappedValue,
               let toastInfo {
                Toast(
                    toastInfo: toastInfo,
                    show: show
                )
            }
        }
    }
}
