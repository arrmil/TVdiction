//
//  ContentView.swift
//  Shared
//
//  Created by Arturas Milius on 2021-10-09.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    //    @State var channel: Channel?
    @ObservedObject var api = API()
    
    @State private var date = Date()
    @State private var selectedDateText: String = "Date"
    
    //Stuff to learn, good way to change date to formatted date string
    private var selectedDate: Binding<Date> {
        Binding<Date>(get: { self.date}, set : {
            self.date = $0
            self.setDateString()
        })
    }
    
    private func setDateString() {
        //typical date formatting stuff
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        //String variable to assign formatted date
        self.selectedDateText = formatter.string(from: self.date)
    }
    
    //Allowing to select only upcoming 7 days, might change this if api support other days
    var closedRange: ClosedRange<Date> {
        let zeroDays = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let sevenDays = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        
        return zeroDays...sevenDays
    }
    
    var body: some View {
        var filterExistingMovies = self.api.movies.filter { movie in
            return movie.imdbRating != "0.0"
        }
        VStack {
            VStack {
                Text("Pasirinkite diena")
                DatePicker("Pasirinkite diena", selection: selectedDate, in: closedRange, displayedComponents: .date)
                    .labelsHidden()
                    .background(Color.red)
                    .cornerRadius(5.0)
                    .padding(.bottom)
                    .onChange(of: selectedDateText, perform: { value in
                        api.loadData(Date: value)
                    })
                Text("Pasirinkta diena: \(selectedDateText)")
            }
            VStack {
                NavigationView {
                    List {
                        ForEach(filterExistingMovies, id: \.self) { movie in
                            NavigationLink(destination: MovieDetailsView(movieRating: movie.imdbRating, moviePoster: movie.Poster, movieTitle: movie.Title, movieYear: movie.Year, movieDescriptionLong: movie.description ?? "")) {
                                TableView(movieTitle: movie.Title, channelName: movie.channelName ?? "", movieStart: movie.start ?? "", movieImdbRating: movie.imdbRating)
                            }
                        }.padding()
                        .navigationTitle("Filmai: ")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
