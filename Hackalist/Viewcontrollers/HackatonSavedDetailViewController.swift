//
//  HackatonSavedDetailViewController.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/28/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class HackatonSavedDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName?.capitalized
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Property for title of the hackaton.
    var titleName: String?
    
    //MARK: Hold the data !!!
    var hackaton: Hackaton!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    
    
}
