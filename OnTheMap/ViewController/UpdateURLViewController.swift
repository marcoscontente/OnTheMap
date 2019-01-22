//
//  UpdateURLViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import MapKit

extension UpdateURLViewController: MKMapViewDelegate {
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if (fullyRendered) {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
            }
        }
    }
}

class UpdateURLViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mediaURLText: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var location: String!
    var longitude: Double?
    var latitude: Double?
    var mediaURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        mediaURLText.delegate = OnTheMapTextFieldDelegate.sharedInstance
        
        updateMapView()
    }
    
    func updateMapView() {
        loadingIndicator.startAnimating()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { (placeMarks, error) in
            
            if (error == nil) {
                // placeMarks can be multiple places.. so how about try the first one?
                //
                if ((placeMarks?.count)! == 1) {
                    let placeMark = placeMarks![0]
                    
                    self.longitude = placeMark.location?.coordinate.longitude
                    self.latitude = placeMark.location?.coordinate.latitude
                    
                    
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    let coordinate = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
                    
                    // Set the coordinate span and map region
                    let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    let coordinateRegion = MKCoordinateRegion(center: coordinate, span: coordinateSpan)
                    
                    // Set the annotation
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    
                    DispatchQueue.main.async {
                        self.mapView.region = coordinateRegion
                        self.mapView.addAnnotation(annotation)
                    }
                }
                else if ((placeMarks?.count)! == 0) {
                    self.alertMapError("Location is not found.")
                }
                else {
                    self.alertMapError("Multiple locations found.")                }
            }
            else {
                self.alertMapError("Error getting location.")
            }
        }
    }
    
    func performUIUpdate() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func alertMapError(_ alertMessage: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func performSubmit(_ sender: Any) {
        
        if (mediaURLText.text! == "") {
            let alert = UIAlertController(title: "Alert", message: "Please enter media url.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let longitude = longitude {
            if let latitude = latitude {
                if let userInfo = ParseClient.sharedInstance().studentInfo {
                    var newUserInfo = userInfo
                    newUserInfo.Longitude = longitude
                    newUserInfo.Latitude = latitude
                    newUserInfo.MediaURL = mediaURLText.text!
                    newUserInfo.MapString = location
                    
                    // PUT
                    if (userInfo.Longitude != longitude || userInfo.Latitude != latitude) {
                        ParseClient.sharedInstance().putStudentInformation(studentInformation: newUserInfo, completionHandlerPutLocation: { (error) in
                            if (error == nil) {
                                self.performUIUpdate()
                            }
                            else {
                                self.alertMapError("Fail to update studentinformation")
                            }
                        })
                    }
                    else { // POST
                        ParseClient.sharedInstance().postStudentInformation(studentInformation: newUserInfo, completionHandlerPostLocation: { (error) in
                            if (error == nil) {
                                self.performUIUpdate()
                            }
                            else {
                                self.alertMapError("Fail to create studentinformation")
                            }
                        })
                    }
                    
                }
            }
        }
    }
    
    @IBAction func performCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
