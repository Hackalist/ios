//
//  VersionViewController.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/26/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class VersionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let version = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as? String {
            self.version = version
        }
        
        if let build = Bundle.main.infoDictionary? ["CFBundleVersion"] as? String {
            self.build = build
        }
        
        buildVersionLabel.text = "ver " + self.version! + "(\(self.build!)) "
        
        
        
        /*
        //MARK: Logo setup
        logoView.layer.cornerRadius = (logoView.layer.cornerRadius) / 2
        logoView.layer.masksToBounds = true
        logoView.layer.shadowColor = UIColor.gray.cgColor
        logoView.layer.shadowOpacity = 1
        logoView.layer.shadowOffset = CGSize.zero
        logoView.layer.shadowRadius = 10
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var version : String?
    var build : String?
    
    
    @IBOutlet weak var buildVersionLabel: UILabel!
    
    
    
    @IBOutlet weak var logoView: UIImageView!
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    

}
