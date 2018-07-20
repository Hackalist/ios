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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    //MARK: Outlets
    
    @IBOutlet weak var hackatonImage: UIImageView!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
