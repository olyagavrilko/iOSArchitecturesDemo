//
//  SongSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Olya Ganeva on 19.03.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SongSearchViewInput: AnyObject {
    var searchResults: [ITunesSong] { get set }

    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SongSearchViewOutput: AnyObject {
    func viewDidSearch(with query: String)
}

class SongSearchPresenter {

    weak var viewInput: (UIViewController & SongSearchViewInput)?
    let interactor: SongSearchInteractorInput

    init(interactor: SongSearchInteractorInput) {
        self.interactor = interactor
    }
}

extension SongSearchPresenter: SongSearchViewOutput {

    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        interactor.requestSongs(with: query) { [weak self] (result) in
            guard let self = self else { return }

            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.searchResults = []
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
}

