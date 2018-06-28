//
//  SavedTableViewController.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/22/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

//MARK: Delegate for passing the data.
protocol AddToSavedHackatonsDelegate {
    func added(hackaton: Hackaton)
}



class SavedTableViewController: UITableViewController, AddToSavedHackatonsDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let savedHackatons  = Hackaton.loadFromFile() {
            hackatonList = savedHackatons
        }
        
    }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      //  print("Hackaton list passed : \(hackatonList)")
        updateUI()
        print("Hackaton list for savedVC: \(hackatonList)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var hackatonList = [Hackaton]()
    


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hackatonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.savedCellIdentifier, for: indexPath)
        configureCell(cell: cell, forItemAt: indexPath)
        return cell
    }
    

    
    //MARK: Custom tableview cell is a must.
    //MARK: Configure Cell.
    func configureCell(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let listingItem = hackatonList[indexPath.row]
        cell.textLabel?.text = listingItem.title
        cell.detailTextLabel?.text = listingItem.notes
        
    
        
        //MARK: Image configuration:
        //configure some image here as well..
        //most probably favicon of the website of the hackaton.
        let baseURL =  URL(string: "https://logo.clearbit.com/") //API.
        let imageURL = listingItem.url
        guard let finalURL = baseURL?.appendingPathComponent(imageURL) else { return }
        
        NetworkController.shared.fetchImage(url: finalURL) { (image) in
            guard let image = image else { return }
            
            //MARK: Since in tableview cells are re-used we need to check the current indexpath!!
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath { //MARK: if the indexpath is changed, skip setting the image.
                    return
                }
                cell.imageView?.image = image
            }
        }
    }
    
    
    
    

    

    
    
    
    
    
    
    //MARK: Delegate implementation.
    func added(hackaton: Hackaton) {
        //MARK: Checking before saving if the element is a dupe.
        if hackatonList.contains(where: { $0.title == hackaton.title }) {
            errorHelper()
        } else if hackatonList.count >= 0 {
            hackatonList.append(hackaton)
            let count = hackatonList.count
            let indexPath = IndexPath(row: count-1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            //MARK: Saving data.
            Hackaton.saveToFile(list: hackatonList)
        }
        //MARK: UI modif.
        updateUI()
    }
    
    
    //MARK: Error handling.
    func errorHelper() {
        let errorAlert = UIAlertController(title: "", message: "Already saved!", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorAlert, animated: true) {
        }
    }
    
    
    
    
    //MARK: Implementation for removing the item from the list.
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            hackatonList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Hackaton.saveToFile(list: hackatonList)
            updateUI()
        }
    }
    
    
    
    //MARK: Edit button handling.
    func updateUI() {
        if hackatonList.count == 0 {
            editButtonItem.isEnabled = false
        } else {
            editButtonItem.isEnabled = true
        }
    }
    
    
    
    //MARK: Adjust the height of the rows.
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    //MARK: Prepare for DetailViewController segue. We use the same VC for two different segues.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.hackatonSavedDetailSegueIdentifier {
            let detailViewController = segue.destination as! HackatonSavedDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            detailViewController.hackaton = hackatonList[index]
            detailViewController.titleName = hackatonList[index].title
            
        }
        
    }
    
    
    
    
    
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
