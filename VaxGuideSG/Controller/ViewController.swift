//
//  ViewController.swift
//  VaxGuideSG
//
//  Created by bryan on 28/7/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var nameLabelBtn: UIButton!
    
    
    var menuFlag = false
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
        
        nameLabelBtn.setTitle("\(users[id].fullname!)", for: .normal)
    }

    @IBAction func menuTapped(_ sender: Any) {
        if !menuFlag{
            leading.constant = 280
            trailing.constant = -280
            
            // set flag to true, menu appeared
            menuFlag = true
        }
        else
        {
            leading.constant = 0
            trailing.constant = 0
            
            // set flag false, menu hide
            menuFlag = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

