//
//  SongSearchViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Olya Ganeva on 19.03.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongSearchViewController: UIViewController {

    // MARK: - Private Properties

    private let songSearchPresenter: SongSearchViewOutput

    private var songSearchView: SongSearchView {
        return self.view as! SongSearchView
    }

    private let searchService = ITunesSearchService()
    var searchResults = [ITunesSong]() {
        didSet {
            songSearchView.tableView.isHidden = false
            songSearchView.tableView.reloadData()
            songSearchView.searchBar.resignFirstResponder()
        }
    }

    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }

    // MARK: - Lifecycle

    init(searchPresenter: SongSearchViewOutput) {
        self.songSearchPresenter = searchPresenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = SongSearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.songSearchView.searchBar.delegate = self
        self.songSearchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
//        self.songSearchView.tableView.delegate = self
        self.songSearchView.tableView.dataSource = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
}

extension SongSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? SongCell else {
            return dequeuedCell
        }
        let song = self.searchResults[indexPath.row]
        let cellModel = SongCellModelFactory.cellModel(from: song)
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
//extension SongSearchViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let song = searchResults[indexPath.row]
//        songSearchPresenter.viewDidSelectSong(song: song)
//    }
//}

//MARK: - UISearchBarDelegate
extension SongSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }

        songSearchPresenter.viewDidSearch(with: query)
    }
}

extension SongSearchViewController: SongSearchViewInput {

    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

    func showNoResults() {
        self.songSearchView.emptyResultView.isHidden = false
    }

    func hideNoResults() {
        self.songSearchView.emptyResultView.isHidden = true
    }

    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
}
