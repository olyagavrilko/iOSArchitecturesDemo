//
//  AppDetailVersionsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Olya Ganeva on 19.03.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailVersionsViewController: UIViewController {

    private let app: ITunesApp

    private var appDetailVersionsView: AppDetailVersionsView {
        return self.view as! AppDetailVersionsView
    }

    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = AppDetailVersionsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
    }

    private func fillData() {
        appDetailVersionsView.versionLabel.text = "Версия \(app.version)"
        appDetailVersionsView.descriptionLabel.text = app.releaseNotes
    }
}
