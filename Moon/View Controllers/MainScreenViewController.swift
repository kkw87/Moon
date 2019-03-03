//
//  MainScreenViewController.swift
//  Moon
//
//  Created by Kevin Wang on 1/22/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    // MARK: - Storyboard
    struct Storyboard {
        static let AccountCreationSegue = "Create Account Segue"
        static let LoginSegue = "Login Segue"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.roundEdges()
            
        }
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlet functions 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToMainScreen(withSegue : UIStoryboardSegue) {
        
    }

}
