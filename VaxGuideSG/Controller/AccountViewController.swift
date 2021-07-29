//
//  AccountViewController.swift
//  VaxGuideSG
//
//  Created by Owrmac on 29/7/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nricLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var documentLabel: UILabel!
    @IBOutlet weak var documentImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
