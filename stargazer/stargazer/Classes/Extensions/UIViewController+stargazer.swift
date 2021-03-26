//
//  UIViewController+stargazer.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import UIKit

extension UIViewController{

    func show(error: StargazerError){

        let alert = UIAlertController(title: NSLocalizedString("alert.error.title", comment: "Error alert title"),
                                      message: error.message,
                                      preferredStyle: .alert)

        let cancelAction = UIAlertAction(
            title: NSLocalizedString("alert.error.cancel", comment: "Error alert cancel action title"),
            style: .cancel,
            handler: nil
        )
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
