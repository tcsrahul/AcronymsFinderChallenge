//
//  ViewController.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 27/01/23.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var noResultImageView: UIImageView!
    @IBOutlet weak var acronymResultTableView: UITableView!
    @IBOutlet weak var acronymSearchBar: UISearchBar!
    var dashboardViewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //Setting up View on Dashboard
    private func setupView() {
        dashboardViewModel.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                self?.setupNoDataImage()
                self?.acronymResultTableView.reloadData()
            }
        }
    }

    //Hide and show tableView and imageview based on searchbar text and webservice response data
    private func setupNoDataImage() {
        //Showing no result image when there is no data on table view
        if (acronymSearchBar.text?.count ?? 0) == 0 || dashboardViewModel.getAcronymCount() > 0 {
            setViewHiddenStatus(isHidden: true)
        } else {
            setViewHiddenStatus(isHidden: false)
        }
    }

    //Hide and show tableView and imageview based on status
    private func setViewHiddenStatus(isHidden: Bool) {
        noResultImageView.isHidden = isHidden
        acronymResultTableView.isHidden = !isHidden
    }
}

// MARK: - TableView DataSource methods
extension DashboardVC: UITableViewDataSource {
    //TableView DataSource method in which tableview cell us created
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let result = dashboardViewModel.getAcronyms(for: indexPath.row) {
            let resultCell = ResultTVC.make(result: result, tableView: tableView,
                                            indexPath: indexPath)
            return resultCell
        }
        return UITableViewCell()
    }

    //TableView DataSource method in which tableview number of cells are are returned
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardViewModel.getAcronymCount()
    }
}

// MARK: - SearchBar Delegates methods
extension DashboardVC: UISearchBarDelegate {

    // called when text changes (including clear)
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Ignoring if the searchBar there is no text on searchbar
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return }
        dashboardViewModel.searchAcronym(searchText: searchText)
    }

    // called when text starts editing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    // called when cancel button pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    // called before text changes
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let specialCharacters = CharacterSet.alphanumerics.inverted
        let string = text.trimmingCharacters(in: specialCharacters)
        if string.count < text.count {
            return false
        } else {
            return true
        }
    }
}
