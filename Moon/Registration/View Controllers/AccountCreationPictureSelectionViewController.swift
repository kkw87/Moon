//
//  AccountCreationPictureSelectionViewController.swift
//  Moon
//
//  Created by Kevin Wang on 1/24/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class AccountCreationPictureSelectionViewController: UIViewController {
    
    // MARK: - Animation Constants
    struct AnimationConstants {
        static let ErrorLabelFadeInTime : TimeInterval = 0.25
        static let ErrorLabelFadeOutTime : TimeInterval = 0.25
        
        static let KeyboardAdjustmentAnimationInterval : TimeInterval = 0.25
        
        static let ContinueButtonConstraintOffset : CGFloat = 280
        static let PictureStackViewOffset : CGFloat = 150
    }
    
    // MARK: - Storyboard
    struct Storyboard {
        static let AccountCreationSegue = "Account Created Segue"
    }
    
    // MARK: - String Constants
    struct StringConstants {
        static let AccountCreationAlertTitle = "There was a problem creating your account"
        static let AccountCreationAlertOkayButton = "Done"
        
        static let DefaultAccountCreationAlertMessage = "Please try again"
            }

    // MARK: - User Information
    var userName : String?
    var userPassword : String?
    var userEmail : String?
    
    var userProfileImage : UIImage? {
        didSet {
            pictureSelectionButton.setBackgroundImage(userProfileImage, for: .normal)
                pictureSelectionButton.setTitle("", for: .normal)
        }
    }
    
    // MARK: - Instance variable
    
    private(set) var accountCreator = AccountCreator()
    
    private(set) lazy var photoVC : UIImagePickerController = {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
 
        return imagePickerVC
    }()
    
    
    private var displayNameErrorLabelIsHidden = true {
        didSet {
            if displayNameErrorLabelIsHidden {
                displayNameErrorLabel.hideOver(duration: AnimationConstants.ErrorLabelFadeOutTime)
            } else {
                displayNameErrorLabel.showOver(duration: AnimationConstants.ErrorLabelFadeInTime)
            }
        }
    }
    
    private var profilePictureErrorLabelIsHidden = true {
        didSet {
            if profilePictureErrorLabelIsHidden {
                noProfilePIctureSelectedErrorLabel.hideOver(duration: AnimationConstants.ErrorLabelFadeOutTime)
            } else {
                noProfilePIctureSelectedErrorLabel.showOver(duration: AnimationConstants.ErrorLabelFadeInTime)
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var pictureSelectionButton: UIButton! {
        didSet {
            pictureSelectionButton.makeCircle()
        }
    }
    
    @IBOutlet weak var createAccountButton: UIButton! {
        didSet {
            createAccountButton.roundEdges()
        }
    }
    

    @IBOutlet weak var displayNameTextField: UITextField! {
        didSet {
            displayNameTextField.setupTextField()
            displayNameTextField.delegate = self
        }
    }
    
    
    @IBOutlet weak var displayNameErrorLabel: UILabel! {
        didSet {
            displayNameErrorLabel.roundEdges()
        }
    }
    
    @IBOutlet weak var noProfilePIctureSelectedErrorLabel: UILabel! {
        didSet {
            noProfilePIctureSelectedErrorLabel.roundEdges()
        }
    }
    
    
    // MARK: - Constraints
    @IBOutlet weak var stackViewDistanceToBottom: NSLayoutConstraint!
    @IBOutlet weak var createAccountButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userTappedBackground)))
    }
    
    // MARK: - Outlet functions 
    @IBAction func createAccount(_ sender: Any) {
        
        guard checkForValidInput(userName: displayNameTextField.text) else {
            return
        }
        
        userTappedBackground()
        
        SVProgressHUD.show()
        
        let newUserInformation = AccountCreationModel(userName: userName!, emailAddress: userEmail!, password: userPassword!, userPhoto: userProfileImage, userDisplayName: displayNameTextField.text!)
        
        accountCreator.createUser(withUser: newUserInformation) { (completed, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        
            guard error == nil else {
                DispatchQueue.main.async {
                    let errorAlertVC = UIAlertController(error: error!)
                    self.present(errorAlertVC, animated: true, completion: nil)
                }
                return
            }
            
            guard completed else {
                DispatchQueue.main.async {
                    let defaultErrorAlertVC = UIAlertController(tintColor: nil)
                    self.present(defaultErrorAlertVC, animated: true, completion: nil)
                }
                return
            }
        
            //Save user defaults with email and password
            UserDefaults.standard.userCredentials = (newUserInformation.emailAddress, newUserInformation.password)
            self.performSegue(withIdentifier: Storyboard.AccountCreationSegue, sender: nil)
        }

    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        profilePictureErrorLabelIsHidden = true
        self.present(photoVC, animated: true, completion: nil)
    }
    
    // MARK: - UI Functions
    @objc func userTappedBackground() {
        displayNameTextField.resignFirstResponder()
    }
    
    private func errorCreatingUsingAccount(withMessage : String?) {
        let errorAlertVC = UIAlertController(title: StringConstants.AccountCreationAlertTitle, message: withMessage ?? StringConstants.DefaultAccountCreationAlertMessage, preferredStyle: .alert)
        errorAlertVC.addAction(UIAlertAction(title: StringConstants.AccountCreationAlertOkayButton, style: .default, handler: nil))
        present(errorAlertVC, animated: true, completion: nil)
    }
    
    // MARK: - Input validation
    func checkForValidInput(userName : String?) -> Bool {
        
        guard let name = userName else {
            return false
        }
        
        if name.count == 0 {
            displayNameErrorLabelIsHidden = false
            return false
        }
        
        if userProfileImage == nil {
            profilePictureErrorLabelIsHidden = false
            return false 
        }
        
        
        return true
    }
}

// MARK: - Image picker controller delegate
extension AccountCreationPictureSelectionViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        userProfileImage = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension AccountCreationPictureSelectionViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        displayNameErrorLabelIsHidden = true
        animateForKeyboardAppearance()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateForKeyboardDissapearance()
    }
}

// MARK: - Animation Functions
extension AccountCreationPictureSelectionViewController {
    private func animateForKeyboardAppearance() {
        UIView.animate(withDuration: AnimationConstants.KeyboardAdjustmentAnimationInterval, delay: 0, options: .curveLinear, animations: {
            self.stackViewDistanceToBottom.constant += AnimationConstants.PictureStackViewOffset
            self.createAccountButtonHeightConstraint.constant += AnimationConstants.ContinueButtonConstraintOffset
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateForKeyboardDissapearance() {
        UIView.animate(withDuration: AnimationConstants.KeyboardAdjustmentAnimationInterval, delay: 0, options: .curveLinear, animations: {
            self.stackViewDistanceToBottom.constant -= AnimationConstants.PictureStackViewOffset
            self.createAccountButtonHeightConstraint.constant -= AnimationConstants.ContinueButtonConstraintOffset
            self.view.layoutIfNeeded()
        }, completion: nil)    }
}
