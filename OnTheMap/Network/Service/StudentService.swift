//
//  StudentService.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 31/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class StudentService {
    
    func getStudentsLocations(with parameters: [String: Any],
                              completion: @escaping (_ response: [StudentInformation]?, _ error: Error?) -> Void) {

        let escapedParameters = URLHelper.escapedParameters(parameters)

        var request = URLRequest(url: Service().getPathURL(udacity: false, path: Constants.studentLocationPath, parameters: escapedParameters))

        request.httpMethod = Constants.HTTPMethodGet
        request = Service().setDefaultHeaders(udacity: false, request: request as! NSMutableURLRequest) as URLRequest
        
        Service().serviceRequest(shouldNormalizeData: false, request: request) { (result, error) in
            guard (error == nil) else {
                print("There was an error with your request: \(error!)")
                completion(nil, error)
                return
            }

            guard let results = result?.value(forKey: Constants.studentResult) as? [[String:AnyObject]] else {
                completion(nil, error)
                return
            }
            
            let studentsInformations = StudentInformation.getLocations(from: results)
            SharedSession.shared.studentLocations = studentsInformations
            completion(studentsInformations, nil)
        }
    }
    
    func postStudentLocation(with studentInformation: PostStudentInformation, completion: @escaping (_ error: Error?) -> Void) {
        
        let parameters: [String:Any] = [Constants.uniqueKeyKey: studentInformation.uniqueKey ?? "",
                                        Constants.firstNameKey: studentInformation.firstName ?? "",
                                        Constants.lastNameKey: studentInformation.lastName ?? "",
                                        Constants.mapStringKey: studentInformation.mapString ?? "",
                                        Constants.mediaURLKey: studentInformation.mediaURL ?? "",
                                        Constants.latitudeKey: studentInformation.latitude ?? "",
                                        Constants.longitudeKey: studentInformation.longitude ?? ""]
        let escapedParameters = URLHelper.escapedParameters(parameters)
        
        var request = URLRequest(url: Service().getPathURL(udacity: false, path: Constants.studentLocationPath, parameters: escapedParameters))
        
        request.httpMethod = Constants.HTTPMethodPost
        request = Service().setDefaultHeaders(udacity: false, request: request as! NSMutableURLRequest) as URLRequest
        
        Service().serviceRequest(shouldNormalizeData: false, request: request) { (result, error) in
            guard (error == nil) else {
                completion(error)
                return
            }
            
            guard let createdAt = result?.value(forKey: Constants.createdAt) as? String else {
                completion(error)
                return
            }
            
            guard let objectID = result?.value(forKey: Constants.objectIDKey) as? String else {
                completion(error)
                return
            }
            
            if (!createdAt.isEmpty && !objectID.isEmpty) {
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    func putStudentLocation(with studentInformation: PostStudentInformation, completion: @escaping (_ error: Error?) -> Void) {
        
        let parameters: [String:Any] = [Constants.uniqueKeyKey: studentInformation.uniqueKey ?? "",
                                        Constants.firstNameKey: studentInformation.firstName ?? "",
                                        Constants.lastNameKey: studentInformation.lastName ?? "",
                                        Constants.mapStringKey: studentInformation.mapString ?? "",
                                        Constants.mediaURLKey: studentInformation.mediaURL ?? "",
                                        Constants.latitudeKey: studentInformation.latitude ?? "",
                                        Constants.longitudeKey: studentInformation.longitude ?? ""]
        let escapedParameters = URLHelper.escapedParameters(parameters)
        
        var request = URLRequest(url: Service().getPathURL(udacity: false, path: Constants.studentLocationPath, parameters: escapedParameters))
        
        request.httpMethod = Constants.HTTPMethodPut
        request = Service().setDefaultHeaders(udacity: false, request: request as! NSMutableURLRequest) as URLRequest
        
        Service().serviceRequest(shouldNormalizeData: false, request: request) { (result, error) in
            guard (error == nil) else {
                completion(error)
                return
            }
            
            guard let updateAt = result?.value(forKey: Constants.updatedAtKey) as? String else {
                completion(error)
                return
            }

            if (!updateAt.isEmpty) {
                completion(nil)
            } else {
                completion(error)
            }
        }
    }

}

