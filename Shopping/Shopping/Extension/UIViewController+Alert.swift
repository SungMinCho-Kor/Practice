//
//  UIViewController+Alert.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

import UIKit

extension UIViewController {
    func presentAlert(
        title: String?,
        message: String?,
        actionTitle: String?,
        method: @escaping () -> Void
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: actionTitle,
                style: .default,
                handler: { _ in
                    method()
                })
        )
        present(alert, animated: true)
    }
    
    func presentAlert(
        title: String?,
        message: String?,
        actionTitle: String?
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: actionTitle,
                style: .default
            )
        )
        present(alert, animated: true)
    }
}
