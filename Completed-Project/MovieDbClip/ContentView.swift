//
//  ContentView.swift
//  MovieDbClip
//
//  Created by Alfian Losari on 9/12/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var deeplinkMovieId: Int?
    
    var body: some View {
        MovieListView()
            .sheet(item: $deeplinkMovieId, content: { id in
                NavigationView {
                    MovieDetailView(movieId: id)
                }
            })
            .onContinueUserActivity(
                NSUserActivityTypeBrowsingWeb,
                perform: handleUserActivity
            )
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard
            let incomingURL = userActivity.webpageURL,
            let components = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems,
            let id = queryItems.first(where: { $0.name == "id" })?.value
        else {
            deeplinkMovieId = nil
            return
        }
        deeplinkMovieId = Int(id)
    }
    
}

extension Int: Identifiable {
    public var id: Int { self }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
