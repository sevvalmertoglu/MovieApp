//
//  FilmListView.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 29.08.2024.
//

import SwiftUI

struct FilmListView: View {
    
    @ObservedObject var filmListViewModel : FilmListViewModel
    @State var searchFilm = ""
    
    init(filmListViewModel: FilmListViewModel) {
        self.filmListViewModel = filmListViewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchFilm) {
                    self.filmListViewModel.searchFilms(filmName: searchFilm)
                }.padding()
                
                List(filmListViewModel.movies, id: \.imdbId) { film in
                    HStack {
                        CustomImageView(url: film.poster)
                            .frame(width: 90, height: 130)
                        
                        VStack(alignment: .leading) {
                            Text(film.title)
                                .font(.title3)
                                .foregroundColor(.purple)
                            
                            Text(film.year)
                                .foregroundColor(.orange)
                        }
                    }
                }.navigationTitle(Text("Film List"))
            }
        }
    }
}

#Preview {
    FilmListView(filmListViewModel: FilmListViewModel())
}
