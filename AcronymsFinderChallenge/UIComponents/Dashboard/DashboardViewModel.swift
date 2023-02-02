//
//  DashboardViewModel.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 31/01/23.
//

import Foundation

class DashboardViewModel {

    private var acronym = [AcronymDictionary]() {
        //called when there is any change in array
        didSet {
            self.reloadTableView?()
        }
    }
    var reloadTableView: (()->())?

    //Returns Acronym object
    func getAcronyms(for index: Int) -> LF? {
        return acronym.first?.lfs[index]
    }

    //Returns total number of Acronym count
    func getAcronymCount() -> Int {
        return acronym.first?.lfs.count ?? 0
    }

    //Method to send web service request
    func searchAcronym(searchText: String) {
        NetworkManager.shared.dictionary(shortForm: searchText) { [weak self] result in
            switch result {
            case .success(let acronym):
                self?.acronym = acronym
            case .failure(let error):
                Utility.showAlert(message: error.message)
            }
        }
    }
}
