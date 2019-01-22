//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import FBSDKLoginKit

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            performAlert("Fail to login using facebook")
            return
        }
        
        self.performFBLogin(result.token.tokenString)
    }
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FB Login example : https://www.letsbuildthatapp.com/course_video?id=412
        // Log out first in case it is logged in before
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        
        
        let fbLoginButton = FBSDKLoginButton()
        
        loginStackView.addArrangedSubview(fbLoginButton)
        
        fbLoginButton.delegate = self
        
        emailTextField.delegate = OnTheMapTextFieldDelegate.sharedInstance
        passwordTextField.delegate = OnTheMapTextFieldDelegate.sharedInstance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicator.stopAnimating()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadingIndicator.stopAnimating()
        unsubscribeFromKeyboardNotifications()
    }
    
    
    private func completeLogin() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func performAlert(_ messageString: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            // Login fail
            let alert = UIAlertController(title: "Alert", message: messageString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    private func getCurrentUserInfo() {
        ParseClient
            .sharedInstance()
            .getStudentInformation(completionHandlerLocation: {(studentInfo, error) in
                if (error != nil) {
                    self.performAlert("Fail to get user info")
                }
        })
    }
    
    func performFBLogin(_ fbToken: String) {
        UdacityClient
            .sharedInstance()
            .performFacebookLogin(fbToken, completionHandlerFBLogin: { (error) in
                if (error == nil) {
                    // Get User Info
                    self.getCurrentUserInfo()
                    // Complete Login
                    self.completeLogin()
                } else {
                    self.performAlert("Invalid login or password")
                }
        })
    }
    
    @IBAction func performLogin(_ sender: Any) {
        loadingIndicator.startAnimating()
        if (emailTextField.text! == "" || passwordTextField.text! == "") {
            let alert = UIAlertController(title: "Alert", message: "Please enter email and password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loadingIndicator.stopAnimating()
            return
        }
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        UdacityClient
            .sharedInstance()
            .performUdacityLogin(email, password, completionHandlerLogin: { (error) in
                if let error = error {
                    //self.performAlert("Invalid login or password")
                    self.performAlert(error.localizedDescription)
                } else {
                    // Get User Info
                    self.getCurrentUserInfo()
                    // Complete Login
                    self.completeLogin()
                }
        })
    }
    
    @IBAction func performSignUp(_ sender: Any) {
        let app = UIApplication.shared
        app.open(URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated")!, options: [:])
        
    }
    
    // MARK Keyboard routines
    @objc func keyboardWillShow(_ notification:Notification) {
        if emailTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification) + 100
        }
        
        if passwordTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification) + 100
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if emailTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
        if passwordTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    
}
