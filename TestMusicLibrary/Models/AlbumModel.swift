//
//  AlbumModel.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 14.07.2022.
//

import Foundation

struct AlbumModel: Decodable, Equatable {
    let results: [Album]
}

struct Album: Decodable, Equatable {
    let artistName: String
    let collectionName: String
    let collectionId: Int
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String
}
