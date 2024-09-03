//
//  FilmDetailsViewModel.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 2.09.2024.
//

import Foundation
import SwiftUI

class FilmDetailViewModel : ObservableObject {
    
    @Published var filmDetails : FilmDetailsViewModel?
    
    let downloaderClient = DownloaderClient()
    
    func getFilmDetails(imdbId : String) {
        downloaderClient.downloadFilmDetails(imdbId: imdbId) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let filmDetails):
                DispatchQueue.main.async {
                    self.filmDetails = FilmDetailsViewModel(detail: filmDetails)
                    
                }
            }
        }
    }
    
    func starRating(from rating: Double) -> String {
        let fullStars = Int(rating / 2)
        return String(repeating: "★", count: fullStars) + String(repeating: "☆", count: 5 - fullStars)
    }
    
}

struct FilmDetailsViewModel {
    let detail : FilmDetails
    
    var title : String {
        detail.title
    }
    
    var poster : String {
        detail.poster
    }
    
    var year : String {
        detail.year
    }
    
    var imdbId : String {
        detail.imdbId
    }
    
    var director : String {
        detail.director
    }
    
    var writer : String {
        detail.writer
    }
    
    var awards : String {
        detail.awards
    }
    
    var plot : String {
        detail.plot
    }
    
    var imdbRating : String {
        detail.imdbRating
    }
    
    var genre : String {
        detail.genre
    }
    
    var runtime : String {
        detail.runtime
    }
}

