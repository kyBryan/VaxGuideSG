//
//  VacTourGuideVC.swift
//  VaxGuideSG
//
//  Created by bryan on 28/7/21.
//

import UIKit

//MARK: Tour Guide Step 0
class VacTourGuideVC: UIViewController, URLServiceDelegate {

    @IBOutlet weak var vacQnsLbl: UILabel!
    @IBOutlet weak var vacAddr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For fixing label weird linebreak
        if #available(iOS 14.0, *) {
            vacQnsLbl.lineBreakStrategy = []
        }
        
        // retrieve appointment api and set the appointment location
        let service = URLService()
        service.delegate = self
        service.fetchDataFromServer(urlPath: kAPPOINTMENT)
        
    }
    
    
    func dataFetchedFromServer(dataFromServer: Data?, responseFromServer: URLResponse?, errorFromServer: Error?) {
        if errorFromServer != nil {
            print(errorFromServer!)
        }
        else {
            
            guard (responseFromServer as! HTTPURLResponse).statusCode == 200 else {
                print("Response Code: \((responseFromServer as! HTTPURLResponse).statusCode)")
                print("Something went wrong.")
                return }
            
            // if there is no data, it will return
            guard let dataFromServer = dataFromServer else {
                print("Error: No Data Received from server.")
                return
            }
            
            do {
                let appointmentList = try JSONDecoder().decode([Appointment].self, from: dataFromServer)
                
                for appo in appointmentList {
                    
                    if appo.nric == kUSERNAME {
                        DispatchQueue.main.async {
                            self.vacAddr.text = appo.location
                            kAPPOINTMENTLOCATION = appo.location
                        }
                    
                    }
                    
                }
                
                
                
                
                
            } catch  {
                print(error.localizedDescription)
            }
            
        }
    }
}

//MARK: Tour Guide Step 1
class VacTourGuideVC1: UIViewController {
    
    @IBOutlet weak var vacAddrBigLbl: UILabel!
    
    @IBOutlet weak var mapLayoutIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For fixing label weird linebreak
        if #available(iOS 14.0, *) {
            //vacQnsLbl.lineBreakStrategy = []
        }
        
        vacAddrBigLbl.text = kAPPOINTMENTLOCATION
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        
        mapLayoutIV.addGestureRecognizer(pictureTap)
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
