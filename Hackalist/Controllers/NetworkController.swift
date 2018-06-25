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
    
    
    
    
    
    /*
    //I think I need only one method, which will parse all the months available for the current year thus the handling of which ones should be shown would be left
     on the viewcontroller and display all available hackatons(depends on the filter settings), setting the user
     to see the current, most nearest date for the available hackaton. The logic for the network will be written here, and the date and other stuff would be
     sent from the viewcontroller. Since the date should be available everywhere, I guess I will write it in a model, as a singleton.
 */
    
    
   
    
    
    //MARK: Getting the current year/month data to be parsed. Note that we have two values to be passed in. (current month/date).
    
    func fetchHackatonListForOurTime(year: String, month: String, completion: @escaping ([Month]?) -> Void ) {  // should change the july shit here, for any month.
        
        guard let initialListingURL = baseURL.appendingPathComponent(year + "/" + "0" + month + ".json").withHTTPS() else {
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        
        
        print("Here is the listingURL : \(initialListingURL)")
        
        let task = URLSession.shared.dataTask(with: initialListingURL) { (data, response, err) in
            //code
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let listingItems = try? jsonDecoder.decode(Listing.self, from: data) {
               
                print("\(String(describing: response)) and \(String(describing: err))")
                completion(listingItems.months)
            } else {
                print("\(String(describing: response)) and \(String(describing: err))")
               completion(nil)
            }
            
        }
        task.resume()
    }
    
    
    
    

    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
}





















