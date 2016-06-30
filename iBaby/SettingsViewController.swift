//
//  SettingsViewController.swift
//  iBaby
//
//  Created by Calamita, Lorenzo on 27/03/16.
//  Copyright © 2016 Calamita, Lorenzo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var hourlyPay: UISlider!
    @IBOutlet weak var displayHourlySalary: UILabel!
    @IBAction func sliderChange(sender: AnyObject) {
        
        let currentValue = hourlyPay.value
/*
        let DecimalPart = currentValue - round(currentValue)
        if (DecimalPart < 0.25 &&  DecimalPart > -0.25) {
            hourlyPay.value = round(currentValue)
        } else {
 
            hourlyPay.value = round(currentValue) + 0.5
        }
 */
        hourlyPay.value = round(currentValue)
 
        defaults.setFloat(hourlyPay.value, forKey: "hourlySalary")
        displayHourlySalary.text = "\(hourlyPay.value) €"
        
    }
    var defaults = NSUserDefaults.standardUserDefaults()
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let bsArray = defaults.objectForKey("BS")
        if section == 0 {
            return bsArray!.count
        } else {
            let schedule = defaults.objectForKey("defaultWeeklySchedule") as! NSArray
            return schedule[0].count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("bsCell", forIndexPath: indexPath)
      
       
        //cell.textLabel?.text = "CIAO"
        if indexPath.section == 0 {
            let bsArray = defaults.objectForKey("BS") as! NSArray
            cell.textLabel?.text = bsArray[indexPath.row] as? String
        } else {
            let schedule2 = defaults.objectForKey("defaultWeeklySchedule") as! NSArray
            //var sortedSchedule = schedule2.sort({ $0.0 < $1.0 })
            //print(sortedSchedule[0])
            //let dayCodes = [String](sortedSchedule.keys)
            // dayCodes is ["MON", "TUE"]
            
            //let dayBS = [String](sortedSchedule.values)
            // airportNames is ["Toronto Pearson", "London Heathrow"]
            
            
            
            cell.textLabel?.text = "\(schedule2[0][indexPath.row].0) - \(schedule2[0][indexPath.row].1) "
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Baby Sitters"
        } else {
            return "Programma di default"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(defaults.objectForKey("defaultWeeklySchedule")!)
        hourlyPay.value = defaults.floatForKey("hourlySalary")
        displayHourlySalary.text = "\(hourlyPay.value) €"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
