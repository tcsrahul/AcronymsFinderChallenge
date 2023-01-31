//
//  DashboardViewModel.swift
//  AlbertsonChallenge
//
//  Created by 2325761 on 31/01/23.
//

import Foundation

class DashboardViewModel {

    var acronyms = [AcromineDictionary]() {
        didSet {
            self.reloadTableView?()
        }
    }
    var reloadTableView: (()->())?
    func getAcronyms(for index: Int) -> LF? {
        return acronyms.first?.lfs[index]
    }

    func getAcronymCount() -> Int {
        return acronyms.first?.lfs.count ?? 0
    }

    func searchAcronym(searchText: String) {
        NetworkManager.shared.dictionary(shortForm: searchText) { [weak self] result in
            switch result {
            case .success(let acromines):
                self?.acronyms = acromines
            case .failure(let error):
                print(error)
                Utility.showAlert(message: error.message)
            }
        }
    }
}
