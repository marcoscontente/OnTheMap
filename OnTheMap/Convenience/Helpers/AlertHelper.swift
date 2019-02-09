//
//  AlertHelper.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 30/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    static func showAlert(in controller: UIViewController, withTitle title: String?, message: String?, action: UIAlertAction? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action ?? defaultAction)
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showAlert(in controller: UIViewController, withTitle title: String?, message: String?, leftAction: UIAlertAction!, rightAction: UIAlertAction!) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(leftAction)
            alertController.addAction(rightAction)
            controller.present(alertController, animated: true, completion: nil)
        }
    }
}
