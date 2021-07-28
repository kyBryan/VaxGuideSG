//
//  URLService.swift
//  VaxGuideSG
//
//  Created by bryan on 28/7/21.
//

import Foundation

@objc protocol URLServiceDelegate {
    @objc optional func dataFetchedFromServer(dataFromServer: Data?, responseFromServer: URLResponse?, errorFromServer: Error?)
}

class URLService {
    var delegate: AnyObject?
    
    func fetchDataFromServer(urlPath: String, dataToServer: Data = Data()){
        
        let url = URL(string: urlPath)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            self.delegate?.dataFetchedFromServer(dataFromServer: data, responseFromServer: response, errorFromServer: error)
        }
        
        task.resume()
        
    }
    
}
