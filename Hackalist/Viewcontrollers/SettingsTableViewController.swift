//
//  SettingsTableViewController.swift
//  Hackalist
//
//  Created by Andrian Sergheev on 7/25/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.monthPicker.delegate = self
        self.monthPicker.dataSource = self
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        tableView.isScrollEnabled = false
        updateDateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
  
    
    
    //MARK: Outlets
    
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    
    
    
    var monthPickerData : [String] = ["December", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November"]
    var yearPickerData : [String] = ["2014","2015","2016","2017","2018","2019"]
    
    
    
    
    //MARK: Update views
    func updateDateViews() {
        
        // get the current date/year to be shown in the datepicker
        
        
        
        
        
        
        
    }
    
    
    
    
    
    //MARK: Picker view delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch  pickerView {
        case monthPicker:
            return monthPickerData.count
        case yearPicker:
            return yearPickerData.count
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case monthPicker:
            return monthPickerData[row]
        case yearPicker:
            return yearPickerData[row]
        default:
            return "Err"
        }
    }
    
    
    
    
    //MARK: Capture the selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case monthPicker:
            monthLabel.text = monthPickerData[row]
            print("Selected month number \(row)")
        case yearPicker:
            yearLabel.text = yearPickerData[row]
            print("Selected year number \(row)")
        default:
            break
        }
    }
    
    
    
    
    let submitCellIndexPath = IndexPath(row: 0, section: 1)
    
    //MARK: Logic for adjusting cell heights
    
    let monthDatePickerCellIndexPath = IndexPath(row: 1, section: 0)
    let yearDatePickerCellIndexPath = IndexPath(row: 3, section: 0)
    
    
    
  
    
    var isMonthPickerShown: Bool = false {
        didSet {
            monthPicker.isHidden = !isMonthPickerShown
        }
    }
    
    var isYearPickerShown: Bool = false {
        didSet {
            yearPicker.isHidden = !isYearPickerShown
        }
    }
    
    
    
    
    //MARK: Toggle the picker view.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (monthDatePickerCellIndexPath.section, monthDatePickerCellIndexPath.row):
            if isMonthPickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case (yearDatePickerCellIndexPath.section, yearDatePickerCellIndexPath.row):
            if isYearPickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    
    
    
    /* MARK: Explanation:
     1.The date picker corresponding to the cell is already shown, your response is to hide it.
     2.The other date picker is shown, you'll hide it and show the selected date picker.
     3.Neither date picker is shown, you will show the selected datePicker
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (monthDatePickerCellIndexPath.section, monthDatePickerCellIndexPath.row - 1): //minus one, as the click goes on the previous cell anyway.
            if isMonthPickerShown {
                isMonthPickerShown = false
            } else if isYearPickerShown {
                isMonthPickerShown = true
                isYearPickerShown = false
            } else {
                isMonthPickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (yearDatePickerCellIndexPath.section, yearDatePickerCellIndexPath.row - 1):
            if isYearPickerShown {
                isYearPickerShown = false
            } else if isMonthPickerShown {
                isMonthPickerShown = false
                isYearPickerShown = true
            } else {
                isYearPickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            
            
        case (submitCellIndexPath.section, submitCellIndexPath.row):
            
            if isMonthPickerShown == false && isYearPickerShown == false {
                submit()
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
        
    }
    
    
    
    //MARK: Submit my own hackaton:
    
    func submit() {
        guard let submitURL = URL(string: "https://github.com/Hackalist/Hackalist.github.io") else { return }
        UIApplication.shared.openURL(submitURL)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    


}
