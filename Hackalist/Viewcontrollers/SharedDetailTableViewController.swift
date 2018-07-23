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
        setupTableView()
        
        
        
        
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
    
    
    
    
    
    
    func setupTableView() {
        
        
        //MARK: Configurations.
        notesLabel.numberOfLines = 0
        notesLabel.sizeToFit()
        
        
        let facebookString = NSMutableAttributedString(string: "Facebook")
        let facebookStringWithURL = facebookString.setAsLink(textToFind: hackaton.facebookURL, linkURL: hackaton.facebookURL)
        
        
        
        
        if facebookStringWithURL {
            socialLabel.text = facebookStringWithURL.description
        } else {
            socialLabel.text = "nothing"
        }
        
        
        
        
        
        
        
        socialLabel.textColor = .blue
        websiteLabel.textColor = .blue
        
        
        
        /*
        // Attributed String for Label
        let plainText = "Apkia"
        let styledText = NSMutableAttributedString(string: plainText)
        // Set Attribuets for Color, HyperLink and Font Size
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14.0), NSLinkAttributeName:NSURL(string: "http://apkia.com/")!, NSForegroundColorAttributeName: UIColor.blueColor()]
        styledText.setAttributes(attributes, range: NSMakeRange(0, plainText.characters.count))
        registerLabel.attributedText = styledText
        
        */
        
        
        
        titleLabel.text = hackaton.title
        websiteLabel.text = hackaton.url
        
        
        cityLabel.text = hackaton.city.capitalized
        hostLabel.text = hackaton.host.capitalized
        dateLabel.text = hackaton.startDate + " - " + hackaton.endDate
        yearLabel.text = hackaton.year
        lengthLabel.text = hackaton.length + " days"
        notesLabel.text = hackaton.notes.capitalized
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





extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}




