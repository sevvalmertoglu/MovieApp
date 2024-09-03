//
//  MainView.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 3.09.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MovieMenuView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Menu")
                }
            
            FilmListView(filmListViewModel: FilmListViewModel())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }.accentColor(.black)
    }
}

#Preview {
    MainView()
}
