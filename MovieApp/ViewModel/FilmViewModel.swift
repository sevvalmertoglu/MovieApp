//
//  FilmViewModel.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 29.08.2024.
//

import Foundation
import SwiftUI

class FilmListViewModel : ObservableObject {
    
    @Published var movies = [FilmViewModel]()
    
    let downloaderClient = DownloaderClient()
    
    func searchFilms(filmName : String) {
        downloaderClient.downloadFilms(search: filmName) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let filmArray):
                if let filmArray = filmArray {
                    DispatchQueue.main.async {
                        self.movies = filmArray.map(FilmViewModel.init)
                    }
                }
            }
        }
    }
}

struct FilmViewModel {
    let film : Film
    
    var title : String {
        film.title
    }
    
    var poster : String {
        film.poster
    }
    
    var year : String {
        film.year
    }
    
    var imdbId : String {
        film.imdbId
    }
}
