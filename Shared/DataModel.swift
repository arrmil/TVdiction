//
//  DataModel.swift
//  Tvdiction
//
//  Created by Arturas Milius on 2021-10-09.
//

import Foundation

struct Channel: Codable {
    var diff: Int
    var nextDate: String
    var previousDate: String

    var schedule: Schedule
}

//Decodable, encodable can't have an array's of Any.
struct Schedule: Codable {
    var programme: [Programme]
    var dayName: String
    var date: String
}

struct Programme: Codable, Identifiable, Hashable {
    // give it let else if var it will try to fetch Id in this case string and mix it with id from the file int
    let id = UUID().uuidString
    
    var description_long: String
    var start: String
    var categorystring: String
    var title_original: String
    var year: Int
    
    var channelName: String? // gonna loop through the array of channels
}

struct MovieDetails: Codable, Hashable {
    let id = UUID().uuidString
    
    var Title: String
    var Year: String
    var imdbRating: String
    var Poster: String
    
    var start: String?
    var channelName: String?
    var description: String?
}

class API: ObservableObject {
    @Published var programme = [Programme]()
    @Published var movies = [MovieDetails]()
    
    init() {
//        loadData()
    }
    
    let channelList: [String] = ["tv3-2","lnk","tv6-2"]
    
    func loadData(Date: String) {
        let myGroup = DispatchGroup()
        var groupCount = 1
        self.programme = []
        
        for tvchannel in channelList {
            myGroup.enter()
            guard let url = URL(string: "https://www.tv24.lt/programme/listing/none/\(Date)?filter=channel&subslug=\(tvchannel)") else {
                print("Invalid URL")
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                var channel = try! JSONDecoder().decode(Channel.self, from: data!)
                var k = 0
                for _ in channel.schedule.programme {
                    channel.schedule.programme[k].channelName = tvchannel
                    k+=1
                }

                DispatchQueue.main.async {
                    self.programme = self.programme + channel.schedule.programme
                    myGroup.leave()
                }
            }.resume()
            
            myGroup.notify(queue: .main) {
                groupCount += 1
                if groupCount == self.channelList.count {
                    self.requestRating()
                }
            }
        }
        
    }
    
    // xD ??
    //TODO: Filter out same values, leave it only start time(programme.start)
    public func filteredProgramme(forCat cat: String) -> [Programme] {
        var myProgramme = [Programme]()
        
        for program in programme {
            if program.categorystring == cat {
                myProgramme.append(program)
            }
        }
        
        return myProgramme
    }
    
    public func requestRating() {
        var index = 0
        let myGroup = DispatchGroup()
        self.movies = []
        
        for program in self.filteredProgramme(forCat: "Filmai") {
            myGroup.enter()
            print("LOL")
            let url = "https://www.omdbapi.com/?apikey=1ecc14c6&t=\(program.title_original)&y=\(program.year)"
            let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            print(urlString)
            guard let urlEndPoint = URL(string: urlString!) else {
                print("MOVIE URL NOT FOUND")
                return
            }
            URLSession.shared.dataTask(with: urlEndPoint) { data, response, error in
                if let data = data {
                    let details = try?JSONDecoder().decode(MovieDetails.self, from: data)
                    DispatchQueue.main.async {
                        self.movies.append(details ?? MovieDetails.init(Title: "No IMDB Found", Year: "", imdbRating: "0.0", Poster: ""))
//                        print(index)
                        self.movies[index].start = program.start
                        self.movies[index].channelName = program.channelName
                        self.movies[index].description = program.description_long
//                        print(self.movies[index])
                        index+=1
                        myGroup.leave()
                    }
                }
            }.resume()
        }
    }
}
