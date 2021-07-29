//
//  LoginViewController.swift
//  VaxGuideSG
//
//  Created by Owrmac on 28/7/21.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    //    let username = "S12345678G"
    //    let password = "12345678"
    
    var coreDataModel = CoreDataModel()
    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        var msg = ""
        var title = ""
        
        if usernameLabel.text!.isEmpty || passwordLabel.text!.isEmpty {
            
            title = "Missing Inputs"
            msg = "Either or both the inputs are incompleted. Please fill it up"
            
        } else {
            
            users = coreDataModel.fetchAllUsers()
            
            for i in 0..<users.count {
                
                // debugging purposes
                print(users[i].nric!)
                print(users[i].password!)
                
                if usernameLabel.text! == users[i].nric! && passwordLabel.text! == users[i].password! {
                    title = "Account exist"
                    msg = "Yey"
                    
                    performSegue(withIdentifier: "logintohome", sender: self)
                    break
                    
                } else if usernameLabel.text! == users[i].nric && passwordLabel.text! != users[i].password {
                    title = "Incorrect password!"
                    msg = "The password you entered is incorrect. Please retry."
                    
                } else if usernameLabel.text! != users[i].nric && passwordLabel.text! != users[i].password {
                    title = "No existing account"
                    msg = "There is no such account in our system. Sign up to continue."
                }
            }
        }
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func unwindToHome(for unwindSegue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
