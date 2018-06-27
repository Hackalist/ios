//
//  SearchTableViewController.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/22/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       
/*
        //here goes the network method, which will use the singleton to get the current month/year and pass this to the request. The output will populate the tableview.
        //a button in profile view will offer the possibility to change the search to all possible hackatons, not only the current one.
         
   */
        
        //MARK: Network req & little touch on UI.
        SVProgressHUD.show()
        networkRequest()
        tableView.isHidden = true
        SVProgressHUD.dismiss(withDelay: 0.5)
        tableView.isHidden = false
        
        //MARK: Setup refreshControl.
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkRequest()
        
        //MARK: Quick fix, "just in case"
        if refreshControl?.isRefreshing == true {
            refreshControl?.endRefreshing()
        }
    /*
     //fixes bug with refreshControl freezing while switching tabs
     if tableView.contentOffset.y < 0 {
     tableView.contentOffset = .zero
     } */
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Holding the variables.
    
    var monthListing = [Hackaton]()
    
    
    
    //MARK: Time Variables.
    
    let month = String(DateTon.sharedDate.getTheMonth())
    let year = String(DateTon.sharedDate.getTheYear())
    
    
    
    
    //MARK: UpdateUI
    
    func updateUI(with month: [Hackaton]) {
        DispatchQueue.main.async {
            self.monthListing = month
            self.tableView.reloadData()
        }
    }
    
    
    
    
    //MARK: Error handling.
    func errorHelper() {
        let errorAlert = UIAlertController(title: "Error", message: "Apologies, something went wrong, please try again later...", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorAlert, animated: true) {
            self.networkRequest()
        }
        
    }
    
    
    
    
    
    
    //MARK: Networking request.
     func networkRequest() {
        NetworkController.shared.fetchHackatonListForOurTime(year: self.year, month: self.month) { (month, error) in
            if let listingInfo = month {
                self.updateUI(with: listingInfo)
              //  print("Here is the listingInfo : \(listingInfo)")
            } else {
                if let _ = error {
                    self.errorHelper()
                }
            }
        }
    }
    
    
    

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return monthListing.count
    }
    
    
    
    //MARK: Configure Cell.
    func configureCell(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let listingItem = monthListing[indexPath.row]
        cell.textLabel?.text = listingItem.title
        cell.detailTextLabel?.text = listingItem.city
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.searchCellIdentifier, for: indexPath)
     configureCell(cell: cell, forItemAt: indexPath)
     return cell
        
    }
    
    
    
    
    
    
    
    //MARK: Prepare for DetailViewController segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.hackatonDetailSegueIdentifier {
           let detailViewController = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            detailViewController.titleName = monthListing[index].title
            detailViewController.hackaton = monthListing[index]
        }
        
    }
    

 
    
    
    //MARK: Pull to refresh implementation.

    
    //private let pullToRefresh = UIRefreshControl()
    
    
    
    
    //MARK: Setup refresh control.
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = pullToRefreshControl
        } else {
            tableView.addSubview(pullToRefreshControl!)
        }
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.networkRequest()
        refreshControl.endRefreshing()
    }
    
    
    
    private var pullToRefreshControl: UIRefreshControl? {
        let pullToRefresh = UIRefreshControl()
        pullToRefresh.addTarget(self, action: #selector(SearchTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        pullToRefresh.tintColor = .red
        
        return pullToRefresh
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
