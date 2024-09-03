//
//  FilmListView.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 29.08.2024.
//

import SwiftUI

struct FilmListView: View {
    @ObservedObject var filmListViewModel: FilmListViewModel
    @State var searchFilm = ""
    
    init(filmListViewModel: FilmListViewModel) {
        self.filmListViewModel = filmListViewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(filmListViewModel.movies, id: \.imdbId) { film in
                    NavigationLink(destination: DetailView(imdbId: film.imdbId)
                        .navigationBarBackButtonHidden(true),
                        label: {
                            HStack {
                                CustomImageView(url: film.poster)
                                    .frame(width: 90, height: 130)
                            
                                VStack(alignment: .leading) {
                                    Text(film.title)
                                        .font(.title3)
                                        .bold()
                                
                                    Text(film.year)
                                        .foregroundColor(.gray)
                                }
                            }
                        })
                }
                .navigationTitle(Text("Film List"))
                .searchable(text: $searchFilm, prompt: "Search Films")
                .onChange(of: searchFilm) { _, newValue in
                    self.filmListViewModel.searchFilms(filmName: newValue)
                }
            }
        }
    }
}

#Preview {
    FilmListView(filmListViewModel: FilmListViewModel())
}
