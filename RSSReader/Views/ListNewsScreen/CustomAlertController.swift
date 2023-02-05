//
//  CustomAlertController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/6/23.
//

import Foundation
import UIKit

class CustomAlertController {
    static func showAlert(
        vc: UIViewController,
        title: String,
        customActions: [UIAlertAction]? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        if let actions = customActions {
            actions.forEach { alert.addAction($0) }
        }

        vc.present(alert, animated: true)
    }
}
