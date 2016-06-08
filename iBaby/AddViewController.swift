//
//  AddViewController.swift
//  iBaby
//
//  Created by Calamita, Lorenzo on 22/03/16.
//  Copyright © 2016 Calamita, Lorenzo. All rights reserved.
//

import UIKit
import Foundation

class AddViewController: UIViewController, NSURLSessionDelegate, UIPickerViewDelegate, UITextFieldDelegate {
    
    


    
    override func viewDidLoad() {
        //DataFrom.hidden = true
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "IT")
        dateFormatter.dateFormat = "EEE"
        let todayName = dateFormatter.stringFromDate(NSDate())
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let schedule = defaults.dictionaryForKey("defaultWeeklySchedule") as! [String:String]
        
        let dayCodes = [String](schedule.keys)
        // dayCodes is ["MON", "TUE"]
        
        let dayBS = [String](schedule.values)
        
        // airportNames is ["Toronto Pearson", "London Heathrow"]
       
        for i in 0...dayCodes.count-1 {
            
            print(todayName.uppercaseString)
            print("-")
            print(dayCodes[i])
            if dayCodes[i] == todayName.uppercaseString {
                
                if dayBS[i] == "Chiara" {
                    bsChooser.selectedSegmentIndex = 0
                } else {
                    bsChooser.selectedSegmentIndex = 1
                }

                
            
            }
            
        
        }
        
        DataFrom.date = NSDate()
        
        ore.delegate = self


    }
    

    
    var dataJ: NSMutableData = NSMutableData()
    var start: Double = 0
    var end: Double = 0
    
    @IBAction func sitterUpdate(sender: AnyObject) {
    
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "IT")
        dateFormatter.dateFormat = "EEE"
        let todayName = dateFormatter.stringFromDate(DataFrom.date)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let schedule = defaults.dictionaryForKey("defaultWeeklySchedule") as! [String:String]
        
        let dayCodes = [String](schedule.keys)
        // dayCodes is ["MON", "TUE"]
        
        let dayBS = [String](schedule.values)
        
        // airportNames is ["Toronto Pearson", "London Heathrow"]
        
        for i in 0...dayCodes.count-1 {
            
            print(todayName.uppercaseString)
            print("-")
            print(dayCodes[i])
            if dayCodes[i] == todayName.uppercaseString {
                
                if dayBS[i] == "Chiara" {
                    bsChooser.selectedSegmentIndex = 0
                } else {
                    bsChooser.selectedSegmentIndex = 1
                }
                
                
                
            }
            
            
        }
        
    }
    @IBOutlet weak var DataFrom: UIDatePicker!
    @IBOutlet weak var bsChooser: UISegmentedControl!
    
    
    @IBOutlet weak var oreView: UIView!
    @IBOutlet weak var ore: UITextField!
    
    @IBAction func AddNewRecord(sender: AnyObject) {
        
        AddNewSitterRecord()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("\(self.view.frame.height)")
        OkView.constant = -140
       //self.oreView.frame.origin.y = self.oreView.frame.origin.y + 216
       // ore.frame.origin.y = ore.frame.origin.y - 200
       
    }
    
    @IBOutlet weak var OkView: NSLayoutConstraint!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        OkView.constant = 0
        //ore.frame.origin.y = ore.frame.origin.y + 200
        self.ore.resignFirstResponder()
        return true
    }
    
    func AddNewSitterRecord() {
        
        let babySitter = bsChooser.titleForSegmentAtIndex(bsChooser.selectedSegmentIndex)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "CET")
        dateFormatter.dateFormat="M"
        let month = dateFormatter.stringFromDate( DataFrom.date)
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let hoursdate = dateFormatter.stringFromDate( DataFrom.date)
        
        
        
        if  Double(ore.text!) > 0  {
            
            let url: NSURL = NSURL(string: "http://www.cuttons.com/json/update.php?name=\(babySitter!)&hoursdate=\(hoursdate)&month=\(month)&hourstotal=\(ore.text!)&qtype=i")!
            var session: NSURLSession!
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
            session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
            let task = session.dataTaskWithURL(url)
        
            task.resume()
            
        } else {
            
            let alert=UIAlertController(title: "Ouch!", message: "Controlla gli orari", preferredStyle: UIAlertControllerStyle.Alert)
 
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            

            presentViewController(alert, animated: true, completion: nil)
            

        }
            

        
       
    }
    
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.dataJ.appendData(data);
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
            
            
            
            
        }else {
            print("Data downloaded")
            //print(dataJ)
            
            
        }
        
    }


    

//    let sitterArray = ["Chiara","Tatiana"]
    
    
    
    
    
    
}
