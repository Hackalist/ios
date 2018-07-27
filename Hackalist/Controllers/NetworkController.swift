//
//  NetworkController.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/22/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation
import UIKit


class NetworkController {
    
    
    
    
    static let shared = NetworkController()
    
    //MARK: Base URL     base url with sample req : /2018/07.json
    let baseURL = URL(string: "https://raw.githubusercontent.com/Hackalist/Hackalist.github.io/master/api/1.0")!
    
    //MARK: Getting the current year/month data to be parsed.
    
    func fetchHackatonListForOurTime(year: String, month: String, completion: @escaping ([Hackaton]?,[String]?, Error? ) -> Void ) {  
        
        guard let initialListingURL = baseURL.appendingPathComponent(year + "/" + "0" + month + ".json").withHTTPS() else {
            completion(nil, nil, nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: initialListingURL) { (data, response, err) in
            //code
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let listingItems = try? jsonDecoder.decode(Listing.self, from: data) {
                completion(listingItems.months, listingItems.monthString, nil)
            } else {
               // print("\(String(describing: response)) and \(String(describing: err))")
               completion(nil, nil, err)
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    
    //MARK: Fetch the image.
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                let image = UIImage(data: data  ) {
                completion(image)
                //  print("\(String(describing: response)) and \(String(describing: error))") //
            } else {
                completion(nil)
                // print("\(String(describing: response)) and \(String(describing: error))") //
            }
        }
        task.resume()
    }

    
    
    
    
    
    

    
    
}





















