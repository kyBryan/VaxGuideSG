//
//  SignUpViewController.swift
//  VaxGuideSG
//
//  Created by Owrmac on 28/7/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var fullNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var identityCardNoLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var phoneNoLabel: UITextField!
    
    var coreDataModel = CoreDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        
        if fullNameLabel.text!.isEmpty || passwordLabel.text!.isEmpty || emailLabel.text!.isEmpty || identityCardNoLabel.text!.isEmpty || phoneNoLabel.text!.isEmpty {
            
        } else {
            
            coreDataModel.addNewUser(email: emailLabel.text!, fullname: fullNameLabel.text!, nric: identityCardNoLabel.text!, password: passwordLabel.text!, phone: phoneNoLabel.text!)
    
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
