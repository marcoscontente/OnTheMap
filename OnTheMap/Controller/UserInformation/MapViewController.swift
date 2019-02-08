//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import MapKit

let didFinishPostingUserLocation = Notification.Name("didFinishPostingUserLocation")

class MapViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var mkPointAnnotations = [MKPointAnnotation]()
    private var students: [StudentInformation]?

    override func viewDidLoad() {
        super.viewDidLoad()
        students = SharedSession.shared.studentLocations
        
        loadStudentLocations()
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(MapViewController.loadStudentLocations),
                         name: didFinishPostingUserLocation,
                         object: nil)
    }
    
    deinit {
        NotificationCenter
            .default
            .removeObserver(self,
                            name: didFinishPostingUserLocation,
                            object: nil)
    }
    
    // MARK: - API Requests
    @objc func loadStudentLocations() {
        let parameters: [String:Any] = [Constants.parseParamsOrder: Constants.parseParamsDashUpdatedAt,
                                        Constants.parseParamsLimit: Constants.parseParamsLimitValue]
        
        StudentService().getStudentsLocations(with: parameters, completion: { (studentLocations, error) in
            if (error != nil) {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Error",
                                      message: error?.localizedDescription ?? ErrorMessage.unknown.rawValue,
                                      leftAction: UIAlertAction(title: "Retry",
                                                                style: .default,
                                                                handler: { (action) in
                                                                    self.loadStudentLocations()
                                      }), rightAction: UIAlertAction(title: "Ok",
                                                                     style: .default,
                                                                     handler: nil))
            }
            
            if let students = studentLocations,
                !students.isEmpty {
                self.students = students
                self.configureMapAndCreateMKPointAnnotations(from: self.students)
            }
        })
    }

    // MARK: - API Parsers
    func configureMapAndCreateMKPointAnnotations(from studentLocations: [StudentInformation]?) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        let mkPointAnnotations = createMKPointAnnotations(from: studentLocations)
        if mkPointAnnotations.count > 0 {
            DispatchQueue.main.async {
                self.mapView.addAnnotations(mkPointAnnotations)
            }
        }
    }
    
    func createMKPointAnnotations(from studentLocations: [StudentInformation]?) -> [MKPointAnnotation] {
        guard let studentLocations = studentLocations,
            studentLocations.count > 0 else {
                return [MKPointAnnotation]()
        }
        var mkPointAnnotations = [MKPointAnnotation]()
        for location in studentLocations {
            if let coordinate = location.coordinate,
                let fullName = location.fullName,
                let mediaURL = location.mediaURL {
                    let mkPointAnnotation = MKPointAnnotation()
                    mkPointAnnotation.coordinate = coordinate
                    mkPointAnnotation.title = fullName
                    mkPointAnnotation.subtitle = mediaURL
                    mkPointAnnotations.append(mkPointAnnotation)
                }
        }
        return mkPointAnnotations
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
            guard let annotationSubtitle = view.annotation?.subtitle,
                let link = annotationSubtitle,
                control == view.rightCalloutAccessoryView,
                !link.isEmpty else {
                    AlertHelper.showAlert(in: self,
                                          withTitle: "Error",
                                          message: ErrorMessage.couldNotOpenURL.rawValue)
                    return
            }
            let url = URL(string: link)!
        
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Error",
                                      message: "Sorry, we could'n open '\(link)', try again later.")
            }
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if (fullyRendered) {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
            }
        }
    }
}
