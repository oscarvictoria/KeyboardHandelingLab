//
//  DetailViewController.swift
//  KeyboardHandelingLab
//
//  Created by Oscar Victoria Gonzalez  on 2/3/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var amcLogo: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    
    
    private var keyboardIsVisible = false
    
    private var originalYconstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        usernameTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        unregisterForKeyboardNotification()
    }
    
    
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        
        moveKeyboardUp(keyboardFrame.size.height)
        
    }
    
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        resetUI()
    }
    
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalYconstraint = centerYConstraint // saves original value
        centerYConstraint.constant -= height
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        keyboardIsVisible = true
        
        
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        centerYConstraint.constant -= originalYconstraint.constant
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
