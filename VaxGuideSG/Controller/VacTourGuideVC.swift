//
//  VacTourGuideVC.swift
//  VaxGuideSG
//
//  Created by bryan on 28/7/21.
//

import UIKit
import SKRadioButton // for radio button
import WebKit

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
        
        // tapping on image and binding action to it
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        
        mapLayoutIV.addGestureRecognizer(pictureTap)
    }
    
    // Image View Fullscreen
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

    // Image View Fullscreen dismiss
    @IBAction func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

//MARK: Tour Guide Step 2
class VacTourGuideVC2: UIViewController {
    
    @IBOutlet weak var vacAddrBigLbl: UILabel!
    
    @IBOutlet weak var mapLayoutIV: UIImageView!
    
    @IBOutlet var bkletLbl: UnderlinedLabel!
    
    // Radio Buttons Group
    @IBOutlet var ariSymptRBtnGrp: [SKRadioButton]!
    @IBOutlet var feverRBtnGrp: [SKRadioButton]!
    @IBOutlet var vacTakenRBtnGrp: [SKRadioButton]!
    @IBOutlet var drugAllergyRBtnGrp: [SKRadioButton]!
    @IBOutlet var testPosRBtnGrp: [SKRadioButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For fixing label weird linebreak
        if #available(iOS 14.0, *) {
            //vacQnsLbl.lineBreakStrategy = []
        }
        
        vacAddrBigLbl.text = kAPPOINTMENTLOCATION
        
        // tapping on image and binding action to it
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        mapLayoutIV.addGestureRecognizer(pictureTap)
        
        
        let bookletTap = UITapGestureRecognizer(target: self, action: #selector(self.openVacBooklet))
        bkletLbl.addGestureRecognizer(bookletTap)
        
    }
    
    // Image View Fullscreen
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

    // Image View Fullscreen dismiss
    @IBAction func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    // Creating web view
    private func createWebView(withFrame frame: CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
        if let resourceUrl = URL(string: "https://www.moh.gov.sg/docs/librariesprovider5/vaccination-matter/pfizer-vis-recipients-4-jun.pdf") {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)
            
            return webView
        }
        
        return nil
    }
    
    // Displaying the Webview
    private func displayWebView() {
        if let webView = self.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
            //self.present(webView, animated: true, completion: nil)
        }
    }
    
    // Radio Button Action
    @IBAction func ariSympRBtnGrpAction(_ sender: SKRadioButton) {
        // ARI Symptom Radio Btn Group
        ariSymptRBtnGrp.forEach { (button) in
              button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func feverBtnGrpAction(_ sender: SKRadioButton) {
        // Fever Radio Btn Group
        feverRBtnGrp.forEach { (button) in
              button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func vacTakenBtnGrpAction(_ sender: SKRadioButton) {
        // Vaccine Taken Radio Btn Group
        vacTakenRBtnGrp.forEach { (button) in
              button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func drugAllergyBtnGrpAction(_ sender: SKRadioButton) {
        // Drug Allergies Radio Btn Group
        drugAllergyRBtnGrp.forEach { (button) in
              button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func testPosBtnGrpAction(_ sender: SKRadioButton) {
        // Tested Position Radio Btn Group
        testPosRBtnGrp.forEach { (button) in
              button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func openVacBooklet(_ sender: UnderlinedLabel){
        self.displayWebView()
    }
}
