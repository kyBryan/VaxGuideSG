//
//  AccountViewController.swift
//  VaxGuideSG
//
//  Created by Owrmac on 29/7/21.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var documentImgView: UIImageView!
    @IBOutlet weak var nameTextf: UITextField!
    @IBOutlet weak var emailTextf: UITextField!
    @IBOutlet weak var nricTextf: UITextField!
    @IBOutlet weak var phoneTextf: UITextField!
    @IBOutlet weak var documentLabel: UILabel!
    @IBOutlet weak var updateProfileBtn: UIButton!
    @IBOutlet weak var saveProfileBtn: UIButton!
    
    var coreDataModel = CoreDataModel()
    var users = [Users]()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        let nric = defaults.string(forKey: "nric")
        
        users = coreDataModel.fetchAllUsers()
                
        for i in 0..<users.count {
            if users[i].nric == nric {
                id = i
            }
        }
        
        nricTextf.text = users[id].nric
        nameTextf.text = users[id].fullname
        phoneTextf.text = users[id].phone
        emailTextf.text = users[id].email
        
    }
    
    @IBAction func updateProfileBtn(_ sender: UIButton) {
        
        updateProfileBtn.isHidden = true
        saveProfileBtn.isHidden = false
        
        nameTextf.isUserInteractionEnabled = true
        nricTextf.isUserInteractionEnabled = true
        phoneTextf.isUserInteractionEnabled = true
        emailTextf.isUserInteractionEnabled = true
        
    }

    @IBAction func saveProfileBtn(_ sender: UIButton) {
        
        saveProfileBtn.isHidden = true
        updateProfileBtn.isHidden = false
        
        
        nameTextf.isUserInteractionEnabled = false
        nricTextf.isUserInteractionEnabled = false
        phoneTextf.isUserInteractionEnabled = false
        emailTextf.isUserInteractionEnabled = false
        
        var newName = nameTextf.text!
        var newNric = nricTextf.text!
        var newPhone = phoneTextf.text!
        var newEmail = emailTextf.text!

        coreDataModel.updateUser(user: users[id], email: newEmail, fullname: newName, nric: newNric, phone: newPhone)
        
        users = coreDataModel.fetchAllUsers()
        
        // debugging purposes
        print(users[id].nric!)
        print(users[id].fullname!)
        print(users[id].phone!)
        print(users[id].email!)
        print(users[id].password!)
        
    }
    
    @IBAction func changePasswordBtn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func uploadFileBtn(_ sender: UIButton) {
        
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
