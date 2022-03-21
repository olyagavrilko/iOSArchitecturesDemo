//
//  SongSearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Olya Ganeva on 21.03.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

protocol SongSearchInteractorInput {
    func requestSongs(with query: String, completion: @escaping ITunesSearchService.CompletionSongs)
}

final class SongSearchInteractor: SongSearchInteractorInput {

    private let searchService = ITunesSearchService()

    func requestSongs(with query: String, completion: @escaping ITunesSearchService.CompletionSongs) {
        searchService.getSongs(forQuery: query, completion: completion)
    }
}
