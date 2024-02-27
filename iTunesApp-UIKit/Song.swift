//
//  Song.swift
//  iTunesApp-UIKit
//
//  Created by Maksym Pidlisnyi on 19/12/2023.
//

import Foundation

struct Song: Codable {
    let trackName: String
    let artistName: String
}

struct SongsResponse: Codable {
    let resultCount: Int
    let results: [Song]
}

enum SongError: Error {
    case invalidSearchTerm
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}
