//
//  AppointmentVC.swift
//  VaxGuideSG
//
//  Created by bryan on 29/7/21.
//

import UIKit
import SkyFloatingLabelTextField

class AppointmentVC: UIViewController, URLServiceDelegate {

    // Upcoming
    @IBOutlet weak var locationTF: SkyFloatingLabelTextField!
    @IBOutlet weak var dateTF: SkyFloatingLabelTextField!
    @IBOutlet weak var dosageTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var upcomingView: UIView!
    
    @IBOutlet weak var noUpcomingLbl: UILabel!
    
    // Past
    @IBOutlet weak var pastLocTF: SkyFloatingLabelTextField!
    @IBOutlet weak var pastDateTF: SkyFloatingLabelTextField!
    @IBOutlet weak var pastDosageTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var pastView: UIView!
    @IBOutlet weak var noPastLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                
                // Set for working data, incase kUSERNAME is empty
                if kUSERNAME.isEmpty {
                    kUSERNAME = "S12345678G"
                }
                
                // List of Appointment that matches the NRIC
                var listOfUserAppo : [Appointment] = []
                
                for appo in appointmentList {
                    
                    if appo.nric == kUSERNAME {
                        
                        listOfUserAppo.append(appo)
                    
                        
                    }
                    
                }
                
                
                if listOfUserAppo.isEmpty{
                    // Display no upcoming and past appointment
                    hideUpcomingView()
                    hidePastView()
                }
                else {
                    
                    checkUpcomingAppo(inListOfUserAppo: listOfUserAppo)
                    checkPastAppo(inListOfUserAppo: listOfUserAppo)
                    
                }
                
                
                
            } catch  {
                print(error.localizedDescription)
            }
            
        }
    }
    

    private var ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()
    
    func dateFormatting(inDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: inDate)!
        
        return date
    }
    
    // checking if there is upcoming appo, T = display, F = hide
    func checkUpcomingAppo(inListOfUserAppo : [Appointment]){
        var haveUpAppoFlag = false
        
        // Check whether there is an upcoming appointment
        for appo in inListOfUserAppo {
            let fDate = dateFormatting(inDate: appo.date)
            
            
            if Date() < fDate {
                //Format int into 1st,2nd,3rd string
                var fDosage : String? {
                    return ordinalFormatter.string(from: NSNumber(value: appo.dosage))
                }
                
                DispatchQueue.main.async {
                    self.locationTF.text = appo.location
                    self.dateTF.text = appo.date
                    self.dosageTF.text = fDosage
                }
                
                haveUpAppoFlag = true
                break
            }
        }
        
        if !haveUpAppoFlag {
            // Display no upcoming Appointment
            hideUpcomingView()
            
        }
    }
    
    // checking if there is past appo, T = display, F = hide
    func checkPastAppo(inListOfUserAppo : [Appointment]){
        var haveUpAppoFlag = false
        
        // Check whether there is a past appointment
        for appo in inListOfUserAppo {
            let fDate = dateFormatting(inDate: appo.date)
            
            
            if Date() > fDate {
                //Format int into 1st,2nd,3rd string
                var fDosage : String? {
                    return ordinalFormatter.string(from: NSNumber(value: appo.dosage))
                }
                
                DispatchQueue.main.async {
                    self.pastLocTF.text = appo.location
                    self.pastDateTF.text = appo.date
                    self.pastDosageTF.text = fDosage
                }
                
                haveUpAppoFlag = true
                break
            }
        }
        
        if !haveUpAppoFlag {
            // Display no upcoming Appointment
            hidePastView()
            
        }
    }
    
    func hideUpcomingView(){
        DispatchQueue.main.async {
            self.upcomingView.isHidden = true
            self.noUpcomingLbl.isHidden = false
        }
    }
    
    func hidePastView(){
        DispatchQueue.main.async {
            self.pastView.isHidden = true
            self.noPastLbl.isHidden = false
        }
    }
}
