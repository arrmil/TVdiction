//
//  MovieDetailsView.swift
//  Tvdiction
//
//  Created by Arturas Milius on 2021-11-02.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    let screen = UIScreen.main.bounds
    
    var movieRating: String
    var moviePoster: String
    var movieTitle: String
    var movieYear: String
    var movieDescriptionLong: String
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                MovieDetailsRating(movieRating: movieRating)
            }.zIndex(1)
            .padding(.trailing, 20)
            VStack {
                MovieDetailsImageView(moviePoster: moviePoster)
                    .frame(height: screen.height / 2)
                MovieDetailsDescription(movieTitle: movieTitle, movieYear: movieYear, descriptionLong: movieDescriptionLong)
                    .padding(.top, 40)
            }
        }.ignoresSafeArea()
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieRating: "7.8", moviePoster: "https://m.media-amazon.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg", movieTitle: "Avatar", movieYear: "2009", movieDescriptionLong: "Labai ilgas desc")
    }
}
