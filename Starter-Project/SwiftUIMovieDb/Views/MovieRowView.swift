//
//  MovieRowView.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 9/1/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieRowView: View {
    
    let movie: Movie
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 0) {
                MovieRowImage(imageURL: movie.posterURL)
                    .padding(.trailing, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.body)
                        .lineLimit(4)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct MovieRowImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 88, height: 132)
        .cornerRadius(4)
        .onAppear {
            imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(movie: .stubbedMovie)
    }
}
