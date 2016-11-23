//
//  LoginViewController.swift
//  MonitorizareVot
//
//  Created by Andrei Nastasiu on 11/15/16.
//  Copyright © 2016 Code4Ro. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: RootViewController, UITextFieldDelegate {
    
    // MARK: - iVars
    private var tapGestureRecognizer: UITapGestureRecognizer?
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var codeTextField: UITextField!
    @IBOutlet private weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet private weak var formViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationButtons()
        layout()
        setTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        appFeaturesUnlocked()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Utils
    func keyboardDidShow(notification: Notification) {
        if let userInfo = notification.userInfo, let frame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect {
            formViewBottomConstraint.constant = frame.size.height - buttonHeight.constant
            performKeyboardAnimation()
        }
    }
    
    func keyboardDidHide(notification: Notification) {
        keyboardIsHidden()
    }
    
    func keyboardIsHidden() {
        formViewBottomConstraint?.constant = 0
        performKeyboardAnimation()
        phoneNumberTextField.resignFirstResponder()
        codeTextField.resignFirstResponder()
    }
    
    private func appFeaturesUnlocked() {
        let sectieViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SectieViewController")
        self.navigationController?.setViewControllers([sectieViewController], animated: true)
    
    }
    
    private func setTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardIsHidden))
        self.tapGestureRecognizer = tapGestureRecognizer
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    private func layout() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNavigationButtons() {
    
    }
    
}