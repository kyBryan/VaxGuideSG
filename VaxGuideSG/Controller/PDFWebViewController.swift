//
//  PDFWebViewController.swift
//  VaxGuideSG
//
//  Created by owrmac on 29/7/21.
//

import UIKit
import WebKit

class PDFWebViewController: UIViewController {

    @IBOutlet weak var pdfContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.displayWebView()
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
            self.pdfContainerView.addSubview(webView)
            
        }
    }
    
    @IBAction func closeWebView(_ sender: UIButton){
        print("entered into unwind")
        self.dismiss(animated: true, completion: nil)
    }

}
