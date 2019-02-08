//
//  UserService.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 31/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class StudentService {

    func getStudentLocation(completion: @escaping (_ result: [StudentInformation]?, _ error: Error?) -> Void) {
        
        let parameters: [String:Any] = [Constants.parseParamsOrder: Constants.parseParamsUpdatedAt,
                                        Constants.parseParamsSkip: Constants.parseParamsSkipValue,
                                        Constants.parseParamsLimit: Constants.parseParamsLimitValue]
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
            let studentsLocation = StudentInformation.getLocations(from: results)
            
            if (studentsLocation.count > 0) {
                SharedSession.shared.currentUser = studentsLocation[0]
            }
            completion(SharedSession.shared.studentLocations, nil)
        }
    }

    func getUser(with userID: String, completion: @escaping (_ success: Bool?, _ failure: String?) -> Void) {
        
        var request = URLRequest(url: Service().getPathURL(path: Constants.userPath, pathExtension: "/" + userID))
        
        request.httpMethod = Constants.HTTPMethodGet
        request = Service().setDefaultHeaders(request: request as! NSMutableURLRequest) as URLRequest
        
        Service().serviceRequest(request: request) { (user, error) in
            guard (error == nil) else {
                print("There was an error with your request: \(error!)")
                completion(false, error?.localizedDescription)
                return
            }
            print("********** RESULTS: \(user!)")

            guard let firstName = user?.value(forKey: Constants.firstName) as? String else {
                completion(false,error?.localizedDescription)
                return
            }
            
            guard let lastName = user?.value(forKey: Constants.lastName) as? String else {
                completion(false,error?.localizedDescription)
                return
            }
            
//            if let email = user?.value(forKey: Constants.email) as? Email {
//                guard let address = email.address else {
//                    completion(false,error?.localizedDescription)
//                    return
//                }
//            }
            
            if (user != nil) {
                SharedSession.shared.currentUser?.firstName = firstName
                SharedSession.shared.currentUser?.lastName = lastName
//                SharedSession.shared.userData?.email = address
                completion(true,nil)
            } else {
                completion(false,ErrorMessage.couldNotLoadUserData.rawValue)
            }
            
        }
    }
    
    
    func postStudentLocation(with studentInformation: StudentInformation, completion: @escaping (_ error: Error?) -> Void) {
        
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
            print(String(data: result as! Data, encoding: .utf8)!)
            completion(error)
        }
    }
    
    func putStudentLocation(with studentInformation: StudentInformation, completion: @escaping (_ error: Error?) -> Void) {
        
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
            print(String(data: result as! Data, encoding: .utf8)!)
            completion(error)
        }
    }

}

