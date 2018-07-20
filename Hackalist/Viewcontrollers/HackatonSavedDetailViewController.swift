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
   //     configureImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Property for title of the hackaton.
    var titleName: String?
    
    //MARK: Hold the data !!!
    var hackaton: Hackaton!
    
    
    
    //MARK: Prepare for the child segue. Pass the data to it.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.sharedDetailTableViewController2 {
            guard let childViewController = segue.destination as?  SharedDetailTableViewController else { return }
            childViewController.hackaton = hackaton
        }
    }
    
    
    /*
    //MARK: Image configuration
    
    
    func configureImage() {
        //MARK: Image configuration:
        //configure some image here as well..
        //most probably favicon of the website of the hackaton.
        let baseURL =  URL(string: "https://logo.clearbit.com/") //API.
        let imageURL = hackaton.url
        guard let finalURL = baseURL?.appendingPathComponent(imageURL) else { return }
        
        NetworkController.shared.fetchImage(url: finalURL) { (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                self.hackatonImage.image = image
            }
               // cell.hackatonImage?.layer.cornerRadius = (cell.hackatonImage?.frame.size.width)! / 2
               // cell.hackatonImage?.layer.masksToBounds = true
               // cell.hackatonImage?.image = image
            }
       
        }
    
    
    
    */
    
    
    
    
    
    
    
    
}
