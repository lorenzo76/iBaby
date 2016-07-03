
//
//  ViewController.swift
//  iBaby
//
//  Created by Calamita, Lorenzo on 21/03/16.
//  Copyright © 2016 Calamita, Lorenzo. All rights reserved.
//

import UIKit


import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate {
    @IBOutlet weak var ThisMonth: UISwitch!
    @IBOutlet weak var Payed: UISwitch!
    @IBOutlet weak var downloadingIndicator: UIActivityIndicatorView!
    
  
    @IBAction func Paga(sender: AnyObject) {
        
        print("paga")
        
    }
    
    @IBAction func toggleThisMonth(sender: AnyObject) {
        if  self.ThisMonth.on {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"thisMonth")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey:"thisMonth")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        
        myResults = []
        dataJ = NSMutableData()
        totalizzatore = ["Chiara": 0, "Tatiana":0]
        downloadItems()
    }
    
    @IBAction func togglePayed(sender: AnyObject) {
        if  self.Payed.on {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"Payed")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey:"Payed")
        }
        NSUserDefaults.standardUserDefaults().synchronize()

        myResults = []
        dataJ = NSMutableData()
        totalizzatore = ["Chiara": 0, "Tatiana":0]
        downloadItems()
    }
    
    @IBOutlet weak var RefreshButton: UIButton!
    @IBAction func Refresh(sender: AnyObject) {
        
        myResults = []
        dataJ = NSMutableData()
        totalizzatore = ["Chiara": 0, "Tatiana":0]
        downloadItems()

        
    
        
    }

    @IBAction func Aggiorna(sender: AnyObject) {
        
        myResults = []
        dataJ = NSMutableData()
        downloadItems()
        totalizzatore = ["Chiara": 0, "Tatiana":0]
    
    }

    @IBOutlet weak var table: UITableView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(ViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        myResults = []
        dataJ = NSMutableData()
        totalizzatore = ["Chiara": 0, "Tatiana":0]
        downloadItems()
        
        self.table.reloadData()
        refreshControl.endRefreshing()
    }
    
    var dataJ = NSMutableData()
    var myResults: [[String:String]] = []
    var totalizzatore: [String:Double] = ["Chiara": 0, "Tatiana":0]
    var oreChiara: Double = 0
    var indiceGiornate: Int?
    var pagaOraria: Double = 0
    
    var oreTatiana: Double = 0
    
    func handleSwipe (sender: UISwipeGestureRecognizer) {
        Aggiorna(sender)
        
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Payed.on =        NSUserDefaults.standardUserDefaults().boolForKey("Payed")
        ThisMonth.on = NSUserDefaults.standardUserDefaults().boolForKey("thisMonth")
        self.table.addSubview(self.refreshControl)
        /*
        let loginButton = FBSDKLoginButton.init()
        loginButton.addTarget(self, action: Selector(loginClicked()), forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.center = self.view.center*/
        //self.view.addSubview(loginButton)
        //self.downloadingIndicator.startAnimating()
        //myResults.append(Dict1)
        //myResults.append(Dict2)
        // Do any additional setup after loading the view, typically from a nib.
        //downloadItems()
        
        
    
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resourcvares that can be recreated.
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indiceGiornate = indexPath.row
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if section == 1 {
            return self.myResults.count
        } else {
            return totalizzatore.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellID:String
        
        if indexPath.section == 1 {
    
            
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            //dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            let myDate = dateFormatter.dateFromString(myResults[indexPath.row]["hours_date"]!)
            let currentDate = dateFormatter.stringFromDate(NSDate())
            
            if currentDate == myResults[indexPath.row]["hours_date"]! {
                cellID="TodayCell"
            } else {
            
                if myResults[indexPath.row]["pagato"]! == "1" {
                   cellID="PayedCell"
                } else {
                   cellID="myCell"
                   
                }
            }
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath)
            
            cell.textLabel?.text = self.myResults[indexPath.row]["bs_name"]
            
            dateFormatter.dateFormat = "EEEE dd MMMM"
            dateFormatter.locale = NSLocale(localeIdentifier: "IT")
            let reversedDate = dateFormatter.stringFromDate(myDate!)
            
            cell.detailTextLabel?.text = "\(reversedDate)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("sitterCell", forIndexPath: indexPath)
            cell.textLabel?.text = Array(totalizzatore.keys)[indexPath.row]
            let Arraym = Array(totalizzatore.values)
            let defaults = NSUserDefaults.standardUserDefaults()
            pagaOraria = Double(defaults.floatForKey("hourlySalary"))
            cell.detailTextLabel?.text = "\(Arraym[indexPath.row]) | \(Arraym[indexPath.row] * pagaOraria) €"
            cell.imageView?.image = UIImage(imageLiteral: Array(totalizzatore.keys)[indexPath.row])
            //cell.detailTextLabel?.text = Array(totalizzatore.values)
            return cell
        }
        
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            return "Giornate"
        } else {
            let Arraym = Array(totalizzatore.values)
            let totale = Arraym[0]+Arraym[1]
            let defaults = NSUserDefaults.standardUserDefaults()
            pagaOraria = Double(defaults.floatForKey("hourlySalary"))
            return "Totale Ore: \(totale) | \(totale*pagaOraria) €"
        }

    }
    
    func downloadItems() {
        //downloadingIndicator.startAnimating()
        let url: NSURL = NSURL(string: "http://www.cuttons.com/json/hours.php")!
        //let url: NSURL = NSURL(string: "http://itwine.corp.emc.com")!
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
            self.downloadingIndicator.stopAnimating()
            print("Failed to download data")
            let alert=UIAlertController(title: "Ouch!", message: "Can't download data", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            
            
            presentViewController(alert, animated: true, completion: nil)

            
            
            
        } else {
            print("Data downloaded")
            let dataString = String(data: dataJ, encoding: NSUTF8StringEncoding)
            //print("\(dataString)")
            self.downloadingIndicator.stopAnimating()
            //print(dataJ)
            if ThisMonth.on {
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeZone = NSTimeZone(name: "CET")
                dateFormatter.dateFormat="M"
                let month = dateFormatter.stringFromDate( NSDate())
                self.myResults = self.parseJSON("\(month)")
                print(self.myResults.count)
            } else {
                myResults = parseJSON(nil)
            }
            
          //  let filteredResults = myResults.filter() { $0["bs_month"] == "4" }
            
            //myResults = filteredResults
            
            for i in 0 ..< myResults.count  {
                
                if myResults[i]["pagato"]! == "0" {
                
                    if myResults[i]["bs_name"]! == "Chiara" {
                        if let hoursPerDay = myResults[i]["hours_total"] {
                            
                                totalizzatore["Chiara"] = totalizzatore["Chiara"]! + Double(hoursPerDay)!
                            
                        }
                    } else {
                        if let hoursPerDay = myResults[i]["hours_total"] {
                           
                                totalizzatore["Tatiana"] = totalizzatore["Tatiana"]! + Double(hoursPerDay)!
                            
                        }
                    }
                }
                
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.table.reloadData()
            })
            
            
        }
        
    }
    
    func parseJSON(filterMonthOption: String?) -> [[String:String]] {
        
        var json = [[String:String]]()
        do {
             json = try NSJSONSerialization.JSONObjectWithData (self.dataJ, options:NSJSONReadingOptions.AllowFragments) as! [[String:String]]
        } catch let error as NSError {
            print(error)
        }
        //print(json.count)
        
        if let fO = filterMonthOption {
            if Payed.on == false {
                let filteredJson = json.filter(){ $0["pagato"]! == "0" }
                return filteredJson.filter(){ $0["month"] == fO }
            } else {
                return json.filter(){ $0["month"] == fO }
            }
        } else {
            if Payed.on == false {
                return json.filter(){ $0["pagato"]! == "0" }
            } else {
                return json
            }
            
            
        }
        //print(myResults)
        
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
 
        
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.table.indexPathForSelectedRow {
                if let detViewController = segue.destinationViewController as? DetailViewController {
                    detViewController.giornate = myResults[indexPath.row]
                }
            }
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        //downloadingIndicator.startAnimating()
        myResults = []
        dataJ = NSMutableData()
        totalizzatore = ["Chiara": 0, "Tatiana":0]
        downloadItems()
        
        print ("view appeared")
    }
    
}

