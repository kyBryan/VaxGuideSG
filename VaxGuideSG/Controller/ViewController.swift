//
//  ViewController.swift
//  VaxGuideSG
//
//  Created by owrmac on 28/7/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var menuFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

