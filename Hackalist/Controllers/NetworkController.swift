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
    
    
    //base url with sample req : /2018/07.json
    let baseURL = URL(string: "https://raw.githubusercontent.com/Hackalist/Hackalist.github.io/master/api/1.0")!
    
    
    
    /*
    //I think I need only one method, which will parse all the months available for the current year, and display all available hackatons, setting the user
     to see the current, most nearest date for the available hackaton. The logic for the network will be written here, and the date and other stuff would be
     sent from the viewcontroller, or model, since it is going to persist. Since the date should be available everywhere, I guess I will write it in a model, as a singleton.
 */
    
    
    
    /*
    let query: [String: String] = [
        "year" : "2018",
        "month": "07.json"
    ]
    
    */
    
    
    
    
    
    
    
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





















