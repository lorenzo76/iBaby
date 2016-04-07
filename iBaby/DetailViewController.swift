//
//  DetailViewController.swift
//  iBaby
//
//  Created by Calamita, Lorenzo on 25/03/16.
//  Copyright © 2016 Calamita, Lorenzo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, NSURLSessionDelegate , UITextFieldDelegate {
    
    //MARK: -Actions
    @IBAction func Paga(sender: AnyObject) {
        //updateRecord()
    }
   
    @IBAction func deleteRecord(sender: AnyObject) {
        deleteRecords()
    }
   
    @IBAction func updateRecords(sender: AnyObject) {
        updateRecord()
    }
    
    //MARK: -Outlets
    @IBOutlet weak var Pagato: UISwitch!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var bsChooser: UISegmentedControl!
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var data: UIDatePicker!
    
    var giornate: [String:String]?
    var dataJ = NSMutableData()
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        hours.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //nameLabel.text = giornate!["bs_name"]!
        hours.delegate = self
        if giornate!["bs_name"]! == "Chiara" {
            bsChooser.selectedSegmentIndex = 0
        } else {
            bsChooser.selectedSegmentIndex = 1
        }
        
        hours.text = giornate!["hours_total"]!
        let dateString = giornate!["hours_date"]!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        data.setDate(dateFormatter.dateFromString(dateString)!, animated: false)
        
        //dataLabel.text = "\(giornate!["month"]!)/\(giornate!["day"]!) \(giornate!["pagato"]!)"
        
        if giornate!["pagato"]! == "0" {
            
            Pagato.on = false
        }
        else {
            Pagato.on = true
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRecord() {
        
        let babySitter = bsChooser.titleForSegmentAtIndex(bsChooser.selectedSegmentIndex)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "CET")
        dateFormatter.dateFormat="M"
        let month = dateFormatter.stringFromDate( data.date)
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let hoursdate = dateFormatter.stringFromDate( data.date)
        

        var pagato = ""
        if Pagato.on {
            pagato = "1"
            
        } else {
            pagato = "0"
        }
        
        if  Double(hours.text!) > 0  {
            let url: NSURL = NSURL(string: "http://www.cuttons.com/json/update.php?id=\(giornate!["id"]!)&pagato=\(pagato)&name=\(babySitter)&hoursdate=\(hoursdate)&month=\(month)&hourstotal=\(hours.text!)&qtype=u")!
            
            
            print("http://www.cuttons.com/json/update.php?id=\(giornate!["id"]!)&pagato=\(pagato)&name=\(babySitter)&hoursdate=\(hoursdate)&month=\(month)&hourstotal=\(hours.text!)&qtype=u")
            
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
    
    func deleteRecords() {
        
        let url: NSURL = NSURL(string: "http://www.cuttons.com/json/delete.php?id=\(giornate!["id"]!)")!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
