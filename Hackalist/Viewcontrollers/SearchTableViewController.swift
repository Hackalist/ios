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
        
        SVProgressHUD.show()
        //MARK: TableView settings
        self.tableView.estimatedRowHeight = 190
        self.tableView.rowHeight = UITableView.automaticDimension

        
        //MARK: Load the date saved.
        if let loadedDate = DateStruct.loadFromFile() {
            self.savedDate = loadedDate
        } else {
            print("Nothing saved yet")
        }
        
        
        //MARK: Network req.
        networkRequest()

        tableView.isHidden = true
        SVProgressHUD.show()
        tableView.isHidden = false
        SVProgressHUD.dismiss(withDelay: 1.0)
        
        //MARK: Setup refreshControl.
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //MARK: Quick fix, "just in case"
        if refreshControl?.isRefreshing == true {
            refreshControl?.endRefreshing()
        }
        
        //MARK: Load the dates saved available globally.
        if let loadedDate = DateStruct.loadFromFile() {
            self.savedDate = loadedDate
        }
        
        //MARK: Network req & little touch on UI.
        monthString.removeAll()
        monthListing.removeAll()
        networkRequest()
        tableView.reloadData()
        
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
    
    //MARK: Name of the month as variable.
    var monthString =  [String]()
    
    
    //MARK: Time variable..
    var savedDate: DateStruct = DateStruct.init(month: String(DateTon.sharedDate.getTheMonth()), year: String(DateTon.sharedDate.getTheYear()))
    
    
    //MARK: DispatchQueue. Solves the dataRace for monthString.
    var queue = DispatchQueue(label: "com.monthString.queue")
    
    
    //MARK: UpdateUI
    
    func updateUI(with month: [Hackaton]) {
        
        DispatchQueue.main.async {
            self.monthListing = month
            self.tableView.reloadData()

        }
    }
    
    
    
    
    
    
    //MARK: Error handling.
    func errorHelper() {
        let errorAlert = UIAlertController(title: "Error", message: "Apologies, something went wrong. Please check your connection, or try another dates...", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorAlert, animated: true) {
            self.networkRequest()
        }
        
    }
    
    
    
    
    
    
    //MARK: Networking request.
     func networkRequest() {
            NetworkController.shared.fetchHackatonListForOurTime(year: (self.savedDate.year), month: (self.savedDate.month)) { (month, monthString, error) in
                if let listingInfo = month, let monthString = monthString {
                    self.queue.async { //async as we need to wait for it to complete the task. in contrast with elf.queue.sync { monthString.count } which can wait.
                        self.updateUI(with: listingInfo)
                        self.monthString = monthString
                    }
                } else {
                    self.errorHelper()
                }
            }
    }
    
    
    
    
    //MARK: Tableview row height Setup.
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //250.0
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthListing.count
    }
    

    
    //MARK: Custom tableViewCell.
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.searchCellIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Unable to dequeue SearchTableViewCell")
        }
     
        
        
     
        
        
        //MARK: Cell configuration.
        let listingItem = monthListing[indexPath.row]
        
        
        
        
        cell.hackatonTitle?.text = listingItem.title
        cell.hackatonNotesLabel?.text = listingItem.notes
        cell.hackatonDateLabel?.text = listingItem.startDate + " - " + listingItem.endDate + " " + listingItem.host
        cell.hackatonCityLabel?.text = listingItem.city
        
        
        //MARK: Image configuration:
        //configure some image here as well..
        //most probably image of the website of the hackaton.
        let baseURL =  URL(string: "https://logo.clearbit.com/") //API.
        let imageURL = listingItem.url
        
        //MARK: If image will not load, return the current cell.
        guard let finalURL = baseURL?.appendingPathComponent(imageURL) else {
            return cell
        }
        
        NetworkController.shared.fetchImage(url: finalURL) { (image) in
            guard let image = image else { return }
            
            //MARK: Since in tableview cells are re-used we need to check the current indexpath!!
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath { //MARK: if the indexpath is changed, skip setting the image.
                    return
                }
                
                cell.hackatonImage?.image = image
            }
        }
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
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = pullToRefreshControl
        } else {
            tableView.addSubview(pullToRefreshControl!)
        }
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.networkRequest()
        
        //people like to wait..
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            refreshControl.endRefreshing()
        }
    }
    
    
    
    private var pullToRefreshControl: UIRefreshControl? {
        let pullToRefresh = UIRefreshControl()
        pullToRefresh.addTarget(self, action: #selector(SearchTableViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        pullToRefresh.tintColor = .orange
        
        return pullToRefresh
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return self.queue.sync { monthString.count }
    }
    
    
  
    
    //MARK: Name of the month in section. Would have to be changed in case if all hackatons viewed in the same search result.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "\(monthString[0]) Hackatons for \(savedDate.year.capitalized)"
        default:
            return "\(monthString[0]) Hackatons for \(savedDate.year.capitalized)"
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
