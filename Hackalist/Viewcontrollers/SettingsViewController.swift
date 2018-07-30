//
//  SettingsViewController.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/25/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showReviewKit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: ShowReview Kit.
    func showReviewKit() {
        let launchCount: Int = UserDefaults.standard.integer(forKey: "launchCount")
        //print("App was launched :\(launchCount) times")
        
        
        if #available(iOS 10.3, *) {
            if (launchCount == 3 || launchCount == 10 || launchCount == 50) {
                SKStoreReviewController.requestReview()
            }
        } else {
            /*
            // Fallback on earlier versions of ios.
            if (launchCount == 3 || launchCount == 10 || launchCount == 50) {
                let alert = UIAlertController(title: "Enjoying Hackalist?", message: "Would you consider reviewing this App? It really makes a difference! If not, perhaps you'd like to send me a suggestion to improve it instead?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Review App", style: .destructive, handler: { (action) in
                   
                    
                    // do something here, send him to the itunes webpage.
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                
                
            } */
        }
        
    }
    
    
    
    
    
    

}
