//
//  TableView.swift
//  Tvdiction
//
//  Created by Arturas Milius on 2021-11-01.
//

import SwiftUI

struct TableView: View {
    var movieTitle: String
    var channelName: String
    var movieStart: String
    var movieImdbRating: String
    
    var body: some View {
                HStack {
                    Text(movieTitle)
                        .bold()
                        .lineLimit(2)
                        .frame(maxWidth: 100)
                    Spacer()
                    ChannelName(channelName: channelName)
                    Spacer()
                    Text(movieStart)
                        .bold()
                    Spacer()
                    HStack(spacing: 3) {
                        Text(movieImdbRating)
                            .bold()
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }.font(.title3)
                    //SF Symbols
                    Image(systemName: "greaterthan")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .padding(.leading, 5)
                }
    }
}

struct ChannelName: View {
    var channelName: String
    
    func getChannelName(channelName: String) -> String {
        switch channelName {
        case "tv3-2":
            return "tv3"
        case "lnk":
            return "lnk"
        case "tv6-2":
            return "tv6"
        default:
           return ""
        }
    }
    
    var body: some View {
        Image(getChannelName(channelName: channelName))
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(movieTitle: "A Country Wedding", channelName: "lnk", movieStart: "19:20", movieImdbRating: "9.3")
    }
}
