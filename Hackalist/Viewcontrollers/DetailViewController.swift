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
  
        
        //MARK: Nice bouncing animation.
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        delegate?.added(hackaton: hackaton)
    }
    
    

    
    
    
    
    
    //MARK: Prepare for the child segue. Pass the data to it.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.sharedDetailTableViewController1 {
            guard let childViewController = segue.destination as?  SharedDetailTableViewController else { return }
            childViewController.hackaton = hackaton
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    

}
