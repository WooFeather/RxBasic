//
//  UIViewController+.swift
//  RxBasic
//
//  Created by 조우현 on 2/18/25.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Rx뿌수기", message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "닫기", style: .default) { action in
            completionHandler()
        }
        
        alert.addAction(button)
        
        present(alert, animated: true)
    }
}
