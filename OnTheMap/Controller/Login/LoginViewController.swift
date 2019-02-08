//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookMananger()
        emailTextField.delegate = OnTheMapTextFieldDelegate.sharedInstance
        passwordTextField.delegate = OnTheMapTextFieldDelegate.sharedInstance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    private func setupFacebookMananger() {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        fbLoginButton = FBSDKLoginButton()
        loginStackView.addArrangedSubview(fbLoginButton)
        fbLoginButton.delegate = self
    }
    
    private func getStundentInformation() {
        guard let userID = SharedSession.shared.accountKey else { return }
        SessionService().getUser(with: userID) { (success, error) in
            guard (error == nil) else {
                AlertHelper.showAlert(in: self, withTitle: "Alert", message: error)
                return
            }
            guard (success == true) else {
                AlertHelper.showAlert(in: self, withTitle: "Alert", message: ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            self.completeLogin()
        }
    }
    
    private func completeLogin() {
        DispatchQueue.main.async {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func performFBLogin(_ fbToken: String) {
        SessionService().performFacebookLogin(fbToken) { (success, error) in
            if (success) {
                print("**** login successful ****")
                self.getStundentInformation()
            } else {
                AlertHelper.showAlert(in: self, withTitle: "Alert", message: error)
            }
        }
    }
    
    @IBAction func performLogin(_ sender: Any) {

        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty || !password.isEmpty else {
            AlertHelper.showAlert(in: self,
                                  withTitle: "Alert",
                                  message: ErrorMessage.invalidEmailOrPassword.rawValue)
            return
        }
        
        SessionService().performUdacityLogin(email, password: password) { (success, error) in
            if (success) {
                print("**** login successful ****")
                self.getStundentInformation()
            } else {
                AlertHelper.showAlert(in: self, withTitle: "Alert", message: error)
            }
        }
      
    }
    
    @IBAction func performSignUp(_ sender: Any) {
        let url = URL(string: Constants.udacitySingUpURL)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            AlertHelper.showAlert(in: self, withTitle: "Alert", message: ErrorMessage.unknown.rawValue)
        }
    }
    
    // MARK: - Keyboard routines
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

extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if result.isCancelled {
            AlertHelper.showAlert(in: self, withTitle: "Alert", message: "Login was cancelled")
            return
        }
        if error != nil {
            AlertHelper.showAlert(in: self, withTitle: "Alert", message: error.localizedDescription)
            return
        }
        guard let fbToken = result?.token.tokenString else {
            return
        }
        self.performFBLogin(fbToken)
    }
}
