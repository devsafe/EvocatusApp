//
//  LoginViewController.swift
//  ELegion-Hack
//
//  Created by KONSTANTIN TISHCHENKO on 02.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    
    var adminLogin = ""
    var adminPassword = ""
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if loginField.text == adminLogin && passwordField.text == adminPassword {
            return true
        } else {
            showAlert(title: "Неверный логин или пароль", message: "Проверьте правильность введенных данных.")
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loginField.layer.cornerRadius = 20
//        loginField.layer.borderWidth = 0.5
//        loginField.layer.borderColor = UIColor(named: "main")?.cgColor
//        loginField.clipsToBounds = true
//
//        passwordField.layer.cornerRadius = 20
//        passwordField.layer.borderWidth = 0.5
//        passwordField.layer.borderColor = UIColor(named: "main")?.cgColor
//        passwordField.clipsToBounds = true
//
//        loginButtonOutlet.layer.cornerRadius = 10
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        loginField.layer.cornerRadius = 10
        loginField.layer.borderWidth = 0.5
        loginField.layer.borderColor = UIColor(named: "main")?.cgColor
        loginField.clipsToBounds = true
        
        passwordField.layer.cornerRadius = 10
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.borderColor = UIColor(named: "main")?.cgColor
        passwordField.clipsToBounds = true
        
        loginButtonOutlet.layer.cornerRadius = 18
    }
    
    @objc func keyboardWasShown(notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo as! [String: Any]
    let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    
    scrollBottomConstraint.constant = frame.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
    scrollBottomConstraint.constant = 0
    }
    
    private func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let actionAlertButton = UIAlertAction(title: "Повторить",
                                              style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.loginField.text = ""
            self.passwordField.text = ""
        }
        alertController.addAction(actionAlertButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

