//
//  LoginViewController.swift
//  Moon
//
//  Created by Kevin Wang on 3/1/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    // MARK: - Text Field Types
    enum TextFieldType {
        case LoginTextField
        case PasswordTextField
    }
    
    // MARK: - Storyboard
    struct Storyboard {
        static let LoginSegue = "Login Segue"
    }
    
    // MARK: - Animation Constants
    struct AnimationConstants {
        static let DefaultInterval : TimeInterval = 0.25
        
        static let TextFieldConstraintOffset : CGFloat = 150
        static let ContinueButtonConstraintOffset : CGFloat = 280
    }
    
    // MARK: - Instance variables
    private let textFieldTags = [1 : TextFieldType.LoginTextField, 2 : TextFieldType.PasswordTextField]
    
    private var emailLabelIsHidden = true {
        didSet {
            if emailLabelIsHidden {
                emailErrorLabel.hideOver(duration: AnimationConstants.DefaultInterval)
            } else {
                emailErrorLabel.showOver(duration: AnimationConstants.DefaultInterval)
            }
        }
    }
    
    private var passwordLabelIsHidden = true {
        didSet {
            if passwordLabelIsHidden {
                passwordErrorLabel.hideOver(duration: AnimationConstants.DefaultInterval)
            } else {
                passwordErrorLabel.showOver(duration: AnimationConstants.DefaultInterval)
            }
        }
    }
    
    private var loginManager = LoginManager()


    // MARK: - Outlets
    
    @IBOutlet weak var emailErrorLabel: UILabel! {
        didSet {
            emailErrorLabel.roundEdges()
        }
    }
    @IBOutlet weak var passwordErrorLabel: UILabel! {
        didSet {
            passwordErrorLabel.roundEdges()
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.setupTextField()
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.setupTextField()
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.roundEdges()
        }
    }
    
    // MARK: - Constraints
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!

    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userTappedBackground)))
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Login functions
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
    
    private func loginUser() {
        
        guard validInput(loginEmail: emailTextField.text, loginPassword: passwordTextField.text) else {
            return
        }
        
        loginManager.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            
            guard error == nil else {
                let errorAlertVC = UIAlertController(error: error!)
                self.present(errorAlertVC, animated: true, completion: nil)
                return
            }
            
            //Update user defaults
            UserDefaults.standard.userCredentials = (self.emailTextField.text!, self.passwordTextField.text!)
            self.performSegue(withIdentifier: Storyboard.LoginSegue, sender: nil)
            
        }
        
    }
    
    private func validInput(loginEmail : String?, loginPassword : String?) -> Bool {
        
        if loginEmail == nil || loginEmail!.count == 0 {
            emailLabelIsHidden = false
            return false
        } else if loginPassword == nil || loginPassword!.count == 0 {
            passwordLabelIsHidden = false
            return false
        }
        
        return true
        
    }
    
    // MARK: - Gesture functions
    @objc func userTappedBackground() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

// MARK: - UITextField Delegate functions
extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.backgroundColor = UIColor.textFieldBackgroundColor
        
        animateForKeyboardAppearance()
        
        if let selectedTextField = textFieldTags[textField.tag] {
            switch selectedTextField {
            case .LoginTextField :
                emailLabelIsHidden = true
            case .PasswordTextField :
                passwordLabelIsHidden = true
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        animateForKeyboardDissapearance()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Animation functions 
extension LoginViewController {

    private func animateForKeyboardAppearance() {
        let keyboardAnimation : () -> Void = {
            self.stackViewBottomConstraint.constant += AnimationConstants.TextFieldConstraintOffset
            self.loginButtonBottomConstraint.constant += AnimationConstants.ContinueButtonConstraintOffset
            self.view.layoutIfNeeded()
        }
        
        UIView.animateWith(animationHandler: keyboardAnimation, withDuration: AnimationConstants.DefaultInterval)
    }
    
    private func animateForKeyboardDissapearance() {
        let keyboardAnimation : () -> Void = {
            self.stackViewBottomConstraint.constant -= AnimationConstants.TextFieldConstraintOffset
            self.loginButtonBottomConstraint.constant -= AnimationConstants.ContinueButtonConstraintOffset
            self.view.layoutIfNeeded()

        }
        
        UIView.animateWith(animationHandler: keyboardAnimation, withDuration: AnimationConstants.DefaultInterval)
    }
    
}
