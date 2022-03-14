//
//  MoveDetailsImageView.swift
//  Tvdiction (iOS)
//
//  Created by Arturas Milius on 2021-11-02.
//

import SwiftUI
import Kingfisher

struct MovieDetailsImageView: View {
    var moviePoster: String
    var body: some View {
        VStack {
            KFImage(URL(string: moviePoster))
                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
        }
    }
}

struct MovieDetailsImageView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsImageView(moviePoster: "https://m.media-amazon.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg")
    }
}
