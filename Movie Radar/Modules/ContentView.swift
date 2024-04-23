//
//  ContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            getMovies()
        }, label: {
            Text("Button")
        })
    }
    
    func getMovies() {
        Task {
            if let movieList = try await APIService().getPopularMovies() {
                movieList.results
                    .compactMap { $0.title }
                    .forEach { movie in
                        print(movie)
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
