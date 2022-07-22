//
//  SongsModel.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 18.07.2022.
//

import Foundation

struct SongsModel: Codable {
    let results: [Song]
}

struct Song: Codable {
    let trackName: String?
}
