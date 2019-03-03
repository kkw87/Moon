//
//  AccountCreationLoginDetailsViewController.swift
//  Moon
//
//  Created by Kevin Wang on 1/23/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class AccountCreationLoginDetailsViewController: UIViewController {
    
    // MARK: - Storyboard
    struct Storyboard {
        static let ReturnToMainScreenSegue = "Return To Main Segue"
        static let PictureSegue = "Picture Selection Segue"
    }
    
    // MARK: - Text Field Types
    enum TextFieldType {
        case NameTextField
        case EmailTextField
        case PasswordTextField
    }
    // MARK: - Animation Constants
    struct AnimationConstants {
        static let DefaultInterval : TimeInterval = 0.25
        
        static let LoginTextFieldConstraintOffset : CGFloat = 150
        static let ContinueButtonConstraintOffset : CGFloat = 280
    }

    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.setupTextField()
            nameTextField.delegate = self
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
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.roundEdges()
        }
    }
    
    @IBOutlet weak var nameErrorLabel: UILabel! {
        didSet {
            nameErrorLabel.roundEdges()
        }
    }
    
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
    @IBOutlet weak var emailInUseLabel: UILabel! {
        didSet {
            emailInUseLabel.roundEdges()
        }
    }
    
    // MARK: - Instance Variables
    
    private let textFieldTags = [0 : TextFieldType.NameTextField, 1 : TextFieldType.EmailTextField, 2 : TextFieldType.PasswordTextField]
    
    private let accountVerifier = AccountCredentialsVerifier()
    
    private var nameErrorLabelIsHidden = true {
        didSet {
            if nameErrorLabelIsHidden {
                nameErrorLabel.hideOver(duration: AnimationConstants.DefaultInterval)
            } else {
                nameErrorLabel.showOver(duration: AnimationConstants.DefaultInterval)
            }
        }
    }
    
    private var emailErrorLabelIsHidden = true {
        didSet {
            if emailErrorLabelIsHidden {
                emailErrorLabel.hideOver(duration: AnimationConstants.DefaultInterval)
            } else {
                emailInUseErrorLabelIsHidden = true
                emailErrorLabel.showOver(duration: AnimationConstants.DefaultInterval)
            }
        }
    }
    
    private var emailInUseErrorLabelIsHidden = true {
        didSet {
            if emailInUseErrorLabelIsHidden {
                emailInUseLabel.hideOver(duration: AnimationConstants.DefaultInterval)
            } else {
                emailErrorLabelIsHidden = true
                emailInUseLabel.showOver(duration: AnimationConstants.DefaultInterval)
            }
        }
    }
    
    private var passwordErrorLabelIsHidden = true {
        didSet {
            if passwordErrorLabelIsHidden {
                passwordErrorLabel.hideOver(duration: AnimationConstants.DefaultInterval)
            } else {
                passwordErrorLabel.showOver(duration: AnimationConstants.DefaultInterval)
            }
        }
    }
    
    // MARK: - Constraints
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginTextFieldsBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userTappedBackground)))
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Input functions
    func userEnteredInValidDetails(userName : String?, userEmail : String?, userPassword : String?) -> Bool {

        if userName == nil || userName!.count == 0 {
            nameErrorLabelIsHidden = false
            return false
        }
        
        if userEmail == nil || !userEmail!.isValidEmail() {
            emailErrorLabelIsHidden = false
            return false
        }
        
        if userPassword == nil || userPassword!.count < 7 {
            passwordErrorLabelIsHidden = false
            return false
        }
        
        return true
    }
    
    // MARK: - Outlet functions
    @IBAction func confirmAccountCredentials(_ sender: Any) {

        guard userEnteredInValidDetails(userName: nameTextField.text, userEmail: emailTextField.text, userPassword: passwordTextField.text) else {
            return
        }
        
        guard let userEmail = emailTextField.text else {
            return
        }
        
        SVProgressHUD.show()
        
        accountVerifier.checkEmailForValidity(emailToCheck:userEmail) { [weak self] (completed, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            if completed {
                self?.performSegue(withIdentifier: Storyboard.PictureSegue, sender: nil)
            } else {
                let errorAlertVC : UIAlertController
                if let networkError = error {
                    errorAlertVC = UIAlertController(error: networkError)
                } else {
                    errorAlertVC = UIAlertController()
                }
                
                self?.present(errorAlertVC, animated: true, completion: nil)

            }
        }

    }
    // MARK: - UI Functions
    
    @objc func userTappedBackground() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        switch segueIdentifier {
        case Storyboard.PictureSegue :
            
            guard let pictureSelectionVC = segue.destination as? AccountCreationPictureSelectionViewController else {
                break
            }
            
            let currentUserName = nameTextField.text!
            let currentUserEmail = emailTextField.text!
            let currentUserPassword = passwordTextField.text!
            
            pictureSelectionVC.userName = currentUserName
            pictureSelectionVC.userEmail = currentUserEmail
            pictureSelectionVC.userPassword = currentUserPassword
        default :
            break
        }
        
    }
    
    
}

extension AccountCreationLoginDetailsViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.backgroundColor = UIColor.textFieldBackgroundColor
        
        //Animate views to adjust for keyboard
        animateForKeyboardAppearance()
        
        //If there is an error message from an invalid input, clear it once the user selects the text field
        if let selectedTextField = textFieldTags[textField.tag] {
            
            switch selectedTextField {
            case .NameTextField:
                nameErrorLabelIsHidden = true
            case .EmailTextField :
                emailErrorLabelIsHidden = true
            case .PasswordTextField :
                passwordErrorLabelIsHidden = true
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            animatedForKeyboardDissapearance()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}

//MARK: - Animation functions
extension AccountCreationLoginDetailsViewController {
      
    private func animateForKeyboardAppearance() {
        
        let keyboardAnimation : () -> Void = {
        self.loginTextFieldsBottomConstraint.constant += AnimationConstants.LoginTextFieldConstraintOffset
        
        self.continueButtonBottomConstraint.constant += AnimationConstants.ContinueButtonConstraintOffset
        self.view.layoutIfNeeded()
        }
        
        UIView.animateWith(animationHandler: keyboardAnimation, withDuration: AnimationConstants.DefaultInterval)
    }
    
    private func animatedForKeyboardDissapearance() {
        
        let keyboardAnimation : () -> Void = {
            self.loginTextFieldsBottomConstraint.constant -= AnimationConstants.LoginTextFieldConstraintOffset
            self.continueButtonBottomConstraint.constant -= AnimationConstants.ContinueButtonConstraintOffset
            self.view.layoutIfNeeded()
            
            
        }
        
        UIView.animateWith(animationHandler: keyboardAnimation, withDuration: AnimationConstants.DefaultInterval)
    }

}

