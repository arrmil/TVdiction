//
//  MovieDetailsRating.swift
//  Tvdiction (iOS)
//
//  Created by Arturas Milius on 2021-11-02.
//

import SwiftUI

struct MovieDetailsRating: View {
    var movieRating: String
    var body: some View {
        ZStack {
                Circle()
                    .stroke(Color.black, lineWidth: 0)
            VStack {
                HStack(spacing: 0) {
                        Text(movieRating)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 20))
                    }
                Text("IMDB")
                    .bold()
                    .foregroundColor(.white)
//                    Image("lnk")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
                }
        }
        .background(Color(red: 94 / 255, green: 68 / 255, blue: 202 / 255))
        .clipShape(Circle())
        .frame(width: 90, height: 90)
    }
}

struct MovieDetailsRating_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsRating(movieRating: "7.8")
    }
}
