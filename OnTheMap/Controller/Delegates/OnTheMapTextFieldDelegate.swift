//
//  OnTheMapTextFieldDelegate.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

class OnTheMapTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    static let sharedInstance: OnTheMapTextFieldDelegate = OnTheMapTextFieldDelegate()

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Insert Code after Text Field is Done editing
        textField.resignFirstResponder()
    }
}
