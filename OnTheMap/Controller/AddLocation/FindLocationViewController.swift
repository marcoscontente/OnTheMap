//
//  UpdateLocationViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import CoreLocation

class FindLocationViewController: UIViewController {
    
    @IBOutlet weak var textLocation: UITextField!
    @IBOutlet weak var mediaURLText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textLocation.delegate = OnTheMapTextFieldDelegate.sharedInstance
        mediaURLText.delegate = OnTheMapTextFieldDelegate.sharedInstance
    }
    
    // MARK: - Validations
    func isValidInput() -> Bool {
        guard let address = textLocation.text, !address.isEmpty else {
            AlertHelper.showAlert(in: self,
                                  withTitle: "Error",
                                  message: ErrorMessage.invalidAddress.rawValue)
            return false
        }
        guard let link = mediaURLText.text, !link.isEmpty && link.isValidUrl else {
            AlertHelper.showAlert(in: self,
                                  withTitle: "Error",
                                  message: ErrorMessage.invalidLink.rawValue)
            return false
        }
        return true
    }
    
    // MARK: - API Calls
    private func performForwardGeocode(with addressString: String!,
                                       onSuccess: @escaping ((_ placemark: CLPlacemark) -> ())) {
        self.view.startLoading()
        CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
            if let _ = error {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Error",
                                      message: ErrorMessage.unableToFindLocationForAddress.rawValue)
                self.view.stopLoading()
            } else {
                guard let placemarks = placemarks,
                    let firstPlaceMark = placemarks.first,
                    placemarks.count > 0 && firstPlaceMark.location != nil else {
                        AlertHelper.showAlert(in: self,
                                              withTitle: "Error",
                                              message: ErrorMessage.noMatchingLocationFound.rawValue)
                        self.view.stopLoading()
                        return
                }
                onSuccess(firstPlaceMark)
                self.view.stopLoading()
            }
        }
    }
    
    @IBAction func performCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func performFindOnMap(_ sender: Any) {
        if isValidInput() {
            performForwardGeocode(with: textLocation.text!,
                                  onSuccess: { (placemark) in
                                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
                                    vc.placemark = placemark
                                    vc.link = self.mediaURLText.text
                                    self.navigationController?.pushViewController(vc, animated: false)
            })
        }
    }
    
}
