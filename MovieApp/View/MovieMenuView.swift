//
//  MovieMenuView.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 3.09.2024.
//

import SwiftUI

struct MovieMenuView: View {
    @StateObject private var imageDownloader = ImageDownloaderClient()
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Text("FILM MENU")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title)
                    
                }.padding()
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(0 ..< 10) { _ in
                                GeometryReader { geometry in
                                    MoviePosterView(url: "https://image.tmdb.org/t/p/w500/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg")
                                        .rotation3DEffect(
                                            Angle(degrees: getPercentage(geo: geometry) * 40),
                                            axis: (x: 0.0, y: 1.0, z: 0.0))
                                }
                                .frame(width: 300, height: 250)
                                .padding(.horizontal, -80)
                            }
                        }
                    })
                }
                
                // Categories Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Text("Upcoming")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        Text("Top rated")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        Text("Popular")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        Text("Now Playing")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.3))
                }.padding(.top, -30)
                
                // Movie Posters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        MoviePosterView(url: "https://image.tmdb.org/t/p/w500/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg")
                        MoviePosterView(url: "https://image.tmdb.org/t/p/w500/6KErczPBROQty7QoIsaa6wJYXZi.jpg")
                        MoviePosterView(url: "https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")
                        MoviePosterView(url: "https://image.tmdb.org/t/p/w500/4zLfBbGnuUBLbMVtagTZvzFwS8l.jpg")
                        MoviePosterView(url: "https://image.tmdb.org/t/p/w500/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg")
                    }
                    .padding(.horizontal)
                }
                
                Text("Most Watched")
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
                    .padding(.leading, -180)
                    .padding()
                    
                VStack {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(1 ..< 10, id: \.self) { _ in
                            MoviePosterView(url: "https://image.tmdb.org/t/p/w500/4zLfBbGnuUBLbMVtagTZvzFwS8l.jpg")
                        }
                    }
                }
            }
        }
    }
}

struct MoviePosterView: View {
    let url: String
    
    @StateObject private var imageDownloader = ImageDownloaderClient()
    
    var body: some View {
        VStack {
            if let imageData = imageDownloader.downloadedImage, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 180)
                    .cornerRadius(12)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 180)
                    .cornerRadius(12)
                    .onAppear {
                        imageDownloader.downloadImage(url: url)
                    }
            }
        }
    }
}

#Preview {
    MovieMenuView()
}
