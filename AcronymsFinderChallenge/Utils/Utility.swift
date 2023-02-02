//
//  Utility.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 31/01/23.
//

import UIKit

class Utility {

    //Method that displays alert on top of the window
    class func showAlert(message: String) {
        let alert = UIAlertController(title: Constant.Strings.alert, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: Constant.Strings.ok
                                      , style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
