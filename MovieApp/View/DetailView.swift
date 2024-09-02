//
//  DetailView.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 2.09.2024.
//

import SwiftUI

struct DetailView: View {
    
    let imdbId: String
    @ObservedObject var filmDetailsViewmodel = FilmDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                CustomImageView(url: filmDetailsViewmodel.filmDetails?.poster ?? "")
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                Spacer()
            }
            
            Text(filmDetailsViewmodel.filmDetails?.title ?? "Film Name").font(.title).padding()
            
            Text(filmDetailsViewmodel.filmDetails?.plot ?? "Film Plot").padding()
            
            Text(filmDetailsViewmodel.filmDetails?.director ?? "Film Director").padding()
            
            Text(filmDetailsViewmodel.filmDetails?.writer ?? "Film Writer").padding()
            
            Text(filmDetailsViewmodel.filmDetails?.awards ?? "Film Awards").padding()
            
            Text(filmDetailsViewmodel.filmDetails?.year ?? "Film Year").padding()
            
            Spacer()
            
        }.onAppear(
            perform: {
                self.filmDetailsViewmodel
                    .getFilmDetails(imdbId: imdbId)
            }
        )
        
    }
}

#Preview {
    DetailView(imdbId: "test")
}
