//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var finishButton: UIButton!

    // MARK: - Properties
    var placemark: CLPlacemark!
    var link: String!
    private var location: CLLocation {
        return placemark.location!
    }
    private var mkPointAnnotation: MKPointAnnotation!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithInitialData()
    }
    
    // MARK: - Configuration
    func configureWithInitialData() {
        guard let mkPointAnnotation = createMKPointAnnotation() else {
            AlertHelper.showAlert(in: self,
                                  withTitle: "Error",
                                  message: ErrorMessage.couldNotLoadData.rawValue,
                                  action: UIAlertAction(title: "Ok",
                                                        style: .default,
                                                        handler: { (action) in
                                                            self.navigationController?.popViewController(animated: true)
                                  }))
            return
        }
        self.mkPointAnnotation = mkPointAnnotation
        configureMapAndZoomToLocation()
    }
    
    // MARK: - Helpers
    func createMKPointAnnotation() ->  MKPointAnnotation? {
        guard let firstName = SharedSession.shared.userSession?.firstName,
            let lastName =  SharedSession.shared.userSession?.lastName else {
                return nil
        }
        let mkPointAnnotation = MKPointAnnotation()
        mkPointAnnotation.coordinate = location.coordinate
        mkPointAnnotation.title = "\(firstName) \(lastName)"
        mkPointAnnotation.subtitle = link
        return mkPointAnnotation
    }
    
    func configureMapAndZoomToLocation(){
        mapView.addAnnotation(mkPointAnnotation)
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                    longitudeDelta: 0.1)),
                          animated: true)
        mapView.selectAnnotation(mkPointAnnotation, animated: true)
    }
    
    // MARK: - API Requests
    func addUserLocation() {
        guard let uniqueKey = SharedSession.shared.userSession?.key,
            let firstName = SharedSession.shared.userSession?.firstName,
            let lastName = SharedSession.shared.userSession?.lastName,
            let mapsString = placemark.mapString else {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Error",
                                      message: ErrorMessage.couldNotLoadData.rawValue)
                return
        }

        let studentInformation = PostStudentInformation(uniqueKey: uniqueKey,
                                                        firstName: firstName,
                                                        lastName: lastName,
                                                        mapString: mapsString,
                                                        mediaURL: link,
                                                        latitude: location.coordinate.latitude,
                                                        longitude: location.coordinate.longitude)
        
        self.postUserLocation(with: studentInformation)
    }
    
    func postUserLocation(with user: PostStudentInformation) {
        StudentService().postStudentLocation(with: user) { (error) in
            if (error == nil) {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Success",
                                      message: "Succesfully posted location.",
                                      action: UIAlertAction(title: "Ok",
                                                            style: .default,
                                                            handler: { (action) in
                                                                self.navigationController?.dismiss(animated: true, completion: {
                                                                    NotificationCenter.default.post(name: didFinishPostingUserLocation, object: nil)
                                                                })
                                      }))
            } else {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Error",
                                      message: error?.localizedDescription ?? ErrorMessage.unknown.rawValue,
                                      leftAction: UIAlertAction(title: "Retry",
                                                                style: .default,
                                                                handler: { (action) in
                                                                    self.addUserLocation()
                                      }), rightAction: UIAlertAction(title: "Ok",
                                                                     style: .default,
                                                                     handler: nil))
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func performSubmit(_ sender: Any) {
        addUserLocation()

    }
    
    @IBAction func performCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - MKMapViewDelegate
extension FindLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinViewReuseIdentifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pinViewReuseIdentifier) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinViewReuseIdentifier)
            pinView!.pinTintColor = .red
            return pinView
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
