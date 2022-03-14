//
//  MovieDetailsDescription.swift
//  Tvdiction (iOS)
//
//  Created by Arturas Milius on 2021-11-02.
//

import SwiftUI

struct MovieDetailsDescription: View {
    var movieTitle: String
    var movieYear: String
    var descriptionLong: String
    var body: some View {
        VStack {
            HStack() {
                    Text("\(movieTitle) \(movieYear)")
                        .bold()
                        .font(.title)
                        .foregroundColor(Color(red: 126 / 255, green: 121 / 255, blue: 147 / 255))
                Spacer()
            }
            .padding([.bottom], 20)
            HStack {
                Text(descriptionLong)
                    .foregroundColor(Color(red: 140 / 255, green: 135 / 255, blue: 153 / 255))
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
        .padding([.leading, .trailing], 30)
    }
}

struct MovieDetailsDescription_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsDescription(movieTitle: "Avatar", movieYear: "2009", descriptionLong: "Labai ilgas descriptionas")
    }
}
