//
//  MainTableViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MainTableViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func performLogout(_ sender: Any) {
        doLogout()
    }
    
    @IBAction func performRefresh(_ sender: Any) {
        if (selectedIndex == 0) {
            let vc = selectedViewController as! MapViewController
            vc.loadStudentLocations()
        }
        else {
            let vc = selectedViewController as! ListViewController
            vc.loadStudentLocations()
        }
    }
    
    @IBAction func performAddStudent(_ sender: Any) {
        presentAddLocationView()
    }
    
    func doLogout() {
        SessionService().performLogout { (success, error) in
            if success == true {
                self.updateUIAfterLogout()
            } else {
                AlertHelper.showAlert(in: self, withTitle: "Alert", message: ErrorMessage.unknown.rawValue, leftAction: UIAlertAction(title: "Retry", style: .default, handler: { action in
                    self.doLogout()
                }), rightAction: UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
        }
    }
    
    private func updateUIAfterLogout() {
        DispatchQueue.main.async {
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logOut()
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func presentAddLocationView() {
        let addLocationVC = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationNavigationController")
        self.present(addLocationVC, animated: true, completion: nil)
    }
    
}
