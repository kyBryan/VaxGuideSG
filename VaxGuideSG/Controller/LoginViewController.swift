//
//  LoginViewController.swift
//  VaxGuideSG
//
//  Created by Owrmac on 28/7/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    let username = "S12345678G"
    let password = "12345678"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("helo")
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
        
        if usernameLabel.text!.isEmpty || passwordLabel.text!.isEmpty {
            
            let alert = UIAlertController(title: "Missing Inputs", message: "Either or both the inputs are incompleted. Please fill it up", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else {
            
            if usernameLabel.text! == username && passwordLabel.text! == password {
                
                print("correct")
                
            } else {
                
                let alert = UIAlertController(title: "Incorrect Username or Password", message: "Please key in the correct inputs.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                
            }
            
            
        }
        
    }
    
}
