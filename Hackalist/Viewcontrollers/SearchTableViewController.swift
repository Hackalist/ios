//
//  SearchTableViewController.swift
//  Hackalist
//
//  Created by Sergheev Andrian on 6/22/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit
import SVProgressHUD
//import GoogleMobileAds

//MARK: Note: Should change the logic of holding the hackatons into a dictionary.


class SearchTableViewController: UITableViewController { //GADBannerViewDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        //MARK: TableView settings
        self.tableView.estimatedRowHeight = 190
        self.tableView.rowHeight = UITableViewAutomaticDimension

        
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
        NetworkController.shared.fetchHackatonListForOurTime(year: (self.savedDate.year), month: (self.savedDate.month)) { (month, monthString, error) in
            if let listingInfo = month, let monthString = monthString {
                self.updateUI(with: listingInfo)
                self.monthString = monthString
              //  print("Here is the listingInfo : \(listingInfo)")
            } else {
                if let _ = error {
                    self.errorHelper()
                }
            }
        }
    }
    
    
    
    //MARK: Tableview row height Setup.
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension //250.0
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
        //most probably favicon of the website of the hackaton.
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
        
        //MARK: People like to wait..
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            refreshControl.endRefreshing()
        }
    }
    
    
    
    private var pullToRefreshControl: UIRefreshControl? {
        let pullToRefresh = UIRefreshControl()
        pullToRefresh.addTarget(self, action: #selector(SearchTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        pullToRefresh.tintColor = .orange
        
        return pullToRefresh
    }
    
    
    
    
    
    
    
    
    // MARK: Should get this via a network req.
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return monthString.count //return the number of months
    }
    
    
  
    
    
    
    
    

    
    
    
    
    /*
    
    //MARK: Test code. Showing the hackatons for the whole year.
    
    //MARK : I should change the logic for this. It doesn't group anyhow the hackatons. I guess the right way would be to use a dictionary.
    
    
    
    
 
    
    var wholeYearHackatons =  [ String : [Hackaton] ]()
    
    
    
    //MARK: wrong implementation.
    func showHackatonsForCurrentYear() {
        //MARK: MonthValues.
        let monthValues = [1,2,3,4,5,6,7,8,9,10,11,12]
        
    
        
        //MARK: Parse the responses for the whole year.
        for allMonths in monthValues {
            NetworkController.shared.fetchHackatonListForOurTime(year: self.year, month: String(allMonths)) { (month, monthString, err) in
                if let listingInfo = month, let monthString = monthString {
                    
                    DispatchQueue.main.async {
                        self.wholeYearHackatons.updateValue(listingInfo, forKey: monthString[0] ) // something is wrong with the 0 here.
                        print("Whole year hackatons : \(self.wholeYearHackatons)")
                     //   self.tableView.reloadData()
                    }
                    
                } else {
                    if let _ = err {
                        self.errorHelper()
                    }
                }
            }
        }
    }
    
     
     */
    
    //MARK: Name of the month in section. Should be changed to check for each dictionary key.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            //  return "\(DateTon.sharedDate.getTheMonthString()) Hackatons"
            return "\(monthString[0]) Hackatons for \(savedDate.year.capitalized)"
        case 1:
            return "\(monthString[1]) Hackatons"
        case 2:
            return "\(monthString[2]) Hackatons" //etc...
        case 3:
            return "\(monthString[3]) Hackatons"
        case 4:
            return "\(monthString[4]) Hackatons"
        case 5:
            return "\(monthString[5]) Hackatons"
        case 6:
            return "\(monthString[6]) Hackatons"
        case 7:
            return "\(monthString[7]) Hackatons"
        default:
            return "End"
        }
        
    }
    
 
    
    

    

    
    
    /*
    
    
    //MARK: Ads implementation.
    
    
    var bannerView: GADBannerView!
    
    
    func setupAds() {
        //MARK: Google ads.
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = "ca-app-pub-4165361134979510/5487918601"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
        
    }
    
    
    
    //MARK: AdMob delegates.
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        tableView.tableFooterView?.frame = bannerView.frame
        tableView.tableFooterView = bannerView
        //print("Banner loaded succesfully")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads: \(error)")
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
