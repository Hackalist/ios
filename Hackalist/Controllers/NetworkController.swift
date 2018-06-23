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
    
    //MARK: Base URL
    
    let baseURL = URL(string: "https://github.com/Hackalist/Hackalist.github.io/blob/master/api/1.0/2018/07.json")!
    
    
    let query: [String: String] = [
        "year" : "2018",
        "month": "07.json"
    ]
    
    
    /*
    //MARK: Fetch the hackaton API, by YEAR )
     func fetchHackatonList(query: String, completion: @escaping ([Listing]?) -> Void ) {
        //let url = baseURL.withQueries(query)!
        let jsonDecoder = JSONDecoder()
        
        
        let jsonTask = URLSession.shared.dataTask(with: baseURL) { (data, response, err) in
            
            if let data = data,
                let listingInfo = try? jsonDecoder.decode(Listing.self, from: data) {
                completion(listingInfo.july)
                print("Here is the listing info: \(listingInfo)")
            } else {
                print(err)
            }
        }
        jsonTask.resume()
    }
    
    
    
    
    */
    
    

    
    
}





















