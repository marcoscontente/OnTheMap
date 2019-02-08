//
//  StudentTableViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private var students: [StudentInformation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadStudentLocations()
        students = SharedSession.shared.studentLocations
    }
        
    // MARK: - Configuration
    func configureTableView() {
        tableView.estimatedRowHeight = 100
    }
    
    func loadStudentLocations() {
        let parameters: [String:Any] = [Constants.parseParamsOrder: Constants.parseParamsUpdatedAt,
                                       Constants.parseParamsLimit: Constants.parseParamsLimitValue]
        
        StudentService().getStudentsLocations(with: parameters, completion: { (result, error) in
            if let studentsLocations = result,
                !studentsLocations.isEmpty {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            } else {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Error",
                                      message: error?.localizedDescription ?? ErrorMessage.unknown.rawValue,
                                      leftAction: UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                                        self.loadStudentLocations()
                                      }),
                                      rightAction: UIAlertAction(title: "OK", style: .default, handler: nil))
            }
        })
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let studentsMediaURL = students?[indexPath.row].mediaURL,
            !studentsMediaURL.isEmpty else {
                AlertHelper.showAlert(in: self,
                                      withTitle: "Alert",
                                      message: ErrorMessage.invalidLink.rawValue)
                return
        }
        let url = URL(string: studentsMediaURL)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: { (isSuccess) in
                                        if !isSuccess {
                                            AlertHelper.showAlert(in: self,
                                                                  withTitle: "Error",
                                                                  message: "Sorry, we could'n open '\(studentsMediaURL)'', try again later.")
                                        }
            })
        }
        
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell",
                                                 for: indexPath) as! ListCell
        cell.configure(with: students?[indexPath.row])
        
        return cell
    }
    
}
