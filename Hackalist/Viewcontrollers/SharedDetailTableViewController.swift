//
//  SharedDetailTableViewController.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/20/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class SharedDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        
        //MARK: Set up the tableview.
        tableView.allowsSelection = false
        setupView()
        setupInteraction()
        
        
        
        //MARK: Row height.
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

    
    
    //MARK: Vars
    var hackaton: Hackaton!
    
    
    
    //MARK: Outlets.
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var socialLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var travelLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    
    
    
    
    
    //MARK: Clickable implementation facebook
    
    @IBAction func tapSocialLabel(_ sender: UITapGestureRecognizer) {
        
        
        let socialText = socialLabel.text
        let facebookRange = (socialText! as NSString).range(of: socialLabel.text!)
        
        if sender.didTapAttributedTextInLabel(label: socialLabel, inRange: facebookRange) {
            
           // print("Tapped facebook")
            guard let facebookUrl = URL(string: hackaton.facebookURL) else { return }
            UIApplication.shared.openURL(facebookUrl)
        } else {
           // print("Tapped none.")
        }
        
    }
    
    
    //MARK: Clickable implementation website
    
    @IBAction func tapWebsiteLabel(_ sender: UITapGestureRecognizer) {
        
        
        let websiteText = websiteLabel.text
        let websiteRange = (websiteText! as NSString).range(of: websiteLabel.text!)
        
        
        if sender.didTapAttributedTextInLabel(label: websiteLabel, inRange: websiteRange) {
            
          //  print("Tapped website")
            guard let websiteURL = URL(string: hackaton.url) else { return }
            UIApplication.shared.openURL(websiteURL)
        } else {
          //  print("Tapped none.")
        }
        
    }
    
    
    //MARK: Clickable implementation twitter
    
    @IBAction func tapTwitterLabel(_ sender: UITapGestureRecognizer) {
        
        
        let twitterText = twitterLabel.text
        let twitterRange = (twitterText! as NSString).range(of: twitterLabel.text!)
        
        
        if sender.didTapAttributedTextInLabel(label: twitterLabel, inRange: twitterRange) {
            
          //  print("Tapped twitter")
            guard let twitterURL = URL(string: hackaton.twitterURL) else { return }
            UIApplication.shared.openURL(twitterURL)
        } else {
         //   print("Tapped none.")
        }
        
    }
    

    
    //MARK: Clickable web/social labels checking
    
    
    func setupInteraction() {
        
        if hackaton.facebookURL.count < 5 {
            socialLabel.isEnabled = false
            socialLabel.text = "Facebook not available"
            socialLabel.textColor = .gray
        } else {
            socialLabel.isEnabled = true
            socialLabel.textColor = .blue
            socialLabel.text = "Facebook"
        }
        
        
        
        if hackaton.twitterURL.count < 5 {
            twitterLabel.isEnabled = false
            twitterLabel.text = "Twitter not available"
            twitterLabel.textColor = .gray
        } else {
            twitterLabel.isEnabled = true
            twitterLabel.text = "Twitter"
            twitterLabel.textColor = .blue
        }
        
        
        if hackaton.url.count < 5 {
            websiteLabel.isEnabled = false
            websiteLabel.text = "No website available"
            websiteLabel.textColor = .gray
        } else {
            websiteLabel.isEnabled = true
            websiteLabel.text = "Link"
            websiteLabel.textColor = .blue
        }
        
        
        
    }
    
    
    func setupView() {
        
        socialLabel.text = "Facebook"
        websiteLabel.text = "Link"
        twitterLabel.text = "Twitter"
    
        //MARK: Configurations.
        notesLabel.numberOfLines = 0
        notesLabel.sizeToFit()
        
        
        //MARK: Color for clickable elements.
        socialLabel.textColor = .blue
        websiteLabel.textColor = .blue
        twitterLabel.textColor = .blue
        
        
        //MARK: User interaction, again,
        socialLabel.isUserInteractionEnabled = true
        websiteLabel.isUserInteractionEnabled = true
        
        
        
        titleLabel.text = hackaton.title.capitalized
        cityLabel.text = hackaton.city.capitalized
        hostLabel.text = hackaton.host.capitalized
        dateLabel.text = hackaton.startDate + " - " + hackaton.endDate
        yearLabel.text = hackaton.year
        lengthLabel.text = hackaton.length + " hours"
        notesLabel.text = hackaton.notes
        prizeLabel.text = hackaton.prize.capitalized
        costLabel.text = hackaton.cost.capitalized
        travelLabel.text = hackaton.travel.capitalized
    }
    
    
    
    
    
    //MARK: Tableview Setup.
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Table view data source
     
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     return 0
     }
     */
    
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}









