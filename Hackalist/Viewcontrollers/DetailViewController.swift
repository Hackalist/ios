//
//  DetailViewController.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/22/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Set up the title. Do not forget to fix the issue for longer titles as well.
        title = titleName?.capitalized
       // print("Here is the hackaton : \(hackaton)") //it works.
        setupDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Property for title of the hackaton.
    var titleName: String?
    
    //MARK: Outlets:
    @IBOutlet weak var saveHackatonButtonOutlet: UIButton?
    
    
    //MARK: Hold the data !!!
    var hackaton: Hackaton!
    
    
    //MARK: Delegate
    
    var delegate: AddToSavedHackatonsDelegate?
    
    
    //MARK: Please note that [1] means the indice in the arrays of tabBarControllers. For this scenario it matches the SavedTableViewController.
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?[1] as? UINavigationController,
            let savedTableViewController = navController.viewControllers.last as? SavedTableViewController {
            delegate = savedTableViewController
        }
    }
    
    
    
    @IBAction func saveHackatonButton(_ sender: UIButton) {
        /*
        UIView.animate(withDuration: 0.3) {
         //   self.saveHackatonButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
         //   self.saveHackatonButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        */
        delegate?.added(hackaton: hackaton)
       // print("To be passed: \(hackaton)")
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    

    

}
