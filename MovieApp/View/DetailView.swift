//
//  DetailView.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 2.09.2024.
//

import SwiftUI

struct DetailView: View {
    let imdbId: String
    @ObservedObject var filmDetailViewmodel = FilmDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .frame(maxHeight: .infinity)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottomLeading) {
                        // Movie Poster Image
                        CustomImageView(url: filmDetailViewmodel.filmDetails?.poster ?? "")
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    
                        // Title overlay on the poster
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.7)]),
                                       startPoint: .center, endPoint: .bottom)
                    
                        VStack(alignment: .leading) {
                            Text(filmDetailViewmodel.filmDetails?.title ?? "Film Name")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        
                            HStack {
                                Text("By \(filmDetailViewmodel.filmDetails?.director ?? "Film Director")")
                                Text("•")
                                Text("Released \(filmDetailViewmodel.filmDetails?.year ?? "Film Year")")
                            }
                            .font(.subheadline)
                            .foregroundColor(.white)
                        }
                        .padding()
                    }
                
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .center, spacing: 10) {
                                Text("GENRE").foregroundStyle(.secondary)
                                Text("\(filmDetailViewmodel.filmDetails?.genre ?? "Film Genre")")
                            }
                            Spacer()
                            Divider()
                                .frame(height: 50)
                        
                            VStack(alignment: .center, spacing: 10) {
                                Text("RUNTIME").foregroundStyle(.secondary)
                                Text("\(filmDetailViewmodel.filmDetails?.runtime ?? "Film Runtime")")
                            }
                            Spacer()
                            Divider()
                                .frame(height: 50)
                        
                            if let imdbRatingString = filmDetailViewmodel.filmDetails?.imdbRating,
                               let imdbRating = Double(imdbRatingString)
                            {
                                let stars = filmDetailViewmodel.starRating(from: imdbRating)
                                VStack(alignment: .center, spacing: 10) {
                                    Text("IMDb Rating").foregroundStyle(.secondary)
                                    Text("\(stars) \(filmDetailViewmodel.filmDetails?.imdbRating ?? "")")
                                }
                            } else {
                                Text("IMDb Rating: Not Available")
                            }
                        }
                        .font(.subheadline)
                        .padding(.horizontal)
                    
                        Text("ABOUT \(filmDetailViewmodel.filmDetails?.title ?? "Film Name")")
                            .font(.headline)
                            .padding(.top, 8)
                            .padding(.horizontal)
                    
                        Text(filmDetailViewmodel.filmDetails?.plot ?? "Film Plot")
                            .font(.body)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        HStack {
                            Text("AWARDS:")
                                .bold()
                            Text(filmDetailViewmodel.filmDetails?.awards ?? "Film Awards")
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("WRITER:")
                                .bold()
                            Text(filmDetailViewmodel.filmDetails?.writer ?? "Film Writer")
                        }
                        .padding(.horizontal)
                        
                    
                        Spacer()
                    }
                    .padding(.top, 8)
                }
            }
        }.edgesIgnoringSafeArea(.top)
        .onAppear(
            perform: {
                self.filmDetailViewmodel
                    .getFilmDetails(imdbId: imdbId)
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Toolbar customizations
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.black.opacity(0.5)).frame(width: 40, height: 40))
                }
            }
        }
    }
}

#Preview {
    DetailView(imdbId: "tt3896198")
}
