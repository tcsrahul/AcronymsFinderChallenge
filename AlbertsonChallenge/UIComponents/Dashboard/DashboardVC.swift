//
//  ViewController.swift
//  AlbertsonChallenge
//
//  Created by 2325761 on 27/01/23.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var acromineResultTableView: UITableView!
    @IBOutlet weak var acromineSearchBar: UISearchBar!
    var dashboardViewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        dashboardViewModel.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                self?.acromineResultTableView.reloadData()
            }
        }
    }
}

extension DashboardVC: UITableViewDelegate {
}

extension DashboardVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let result = dashboardViewModel.getAcronyms(for: indexPath.row) {
            let resultCell = ResultTVC.make(result: result, tableView: tableView,
                                            indexPath: indexPath)
            return resultCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardViewModel.getAcronymCount()
    }
}

extension DashboardVC: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dashboardViewModel.searchAcronym(searchText: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
