//
//  BaseViewController.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {
    
    let hud = JGProgressHUD(style: .dark)

    func showHud() {
        hud.show(in: self.view)
    }
    
    func hideHud() {
        hud.dismiss()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil)
        )
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }

}
