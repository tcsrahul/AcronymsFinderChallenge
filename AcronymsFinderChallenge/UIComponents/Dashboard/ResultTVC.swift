//
//  ResultTVC.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import UIKit

class ResultTVC: UITableViewCell {

    private static let identifier = "ResultTVC"
    @IBOutlet weak var resultLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //Creating cell for showing search result
    class func make(result: LF, tableView: UITableView,
                    indexPath: IndexPath) -> ResultTVC {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTVC.identifier,
                                                       for: indexPath) as? ResultTVC else { return ResultTVC() }
        cell.resultLabel.text = result.lf
        return cell
    }
}
