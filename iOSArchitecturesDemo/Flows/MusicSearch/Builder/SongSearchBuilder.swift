//
//  SongSearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Olya Ganeva on 20.03.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class SongSearchBuilder {

    static func build() -> (UIViewController & SongSearchViewInput) {
        let interactor = SongSearchInteractor()
        let presenter = SongSearchPresenter(interactor: interactor)
        let viewController = SongSearchViewController(searchPresenter: presenter)

        presenter.viewInput = viewController
        return viewController
    }
}
