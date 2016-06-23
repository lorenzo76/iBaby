//
//  AppDelegate.swift
//  iBaby
//
//  Created by Calamita, Lorenzo on 21/03/16.
//  Copyright © 2016 Calamita, Lorenzo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setBool(true, forKey: "payed")
        //defaults.setBool(true, forKey: "thisMonth")
        //let defaultWeek: [String:String] = ["LUN":"Tatiana","MAR":"Chiara","MER":"Tatiana","GIO":"Free","FRI":"Chiara" ]
        //defaults.setObject(["Tatiana","Chiara"], forKey: "BS")
        //defaults.setFloat(8.00, forKey: "hourlySalary")
        //let defaultWeek: [String:String] = ["1.LUN":"Tatiana","2.MAR":"Chiara","3.MER":"Tatiana","4.GIO":"Free","5.FRI":"Chiara" ]
        //defaults.setObject (defaultWeek, forKey: "defaultWeeklySchedule")
        

        
        if !defaults.boolForKey("firstLaunch") {
            defaults.setInteger(40, forKey: "Age")
            defaults.setBool(true, forKey: "firstLaunch")
            defaults.setObject(["Tatiana","Chiara"], forKey: "BS")
            defaults.setFloat(8.00, forKey: "hourlySalary")
            let defaultWeek: [String:String] = ["LUN":"Chiara","MAR":"Chiara","MER":"Chiara","GIO":"Chiara","FRI":"Chiara" ]
            defaults.setObject (defaultWeek, forKey: "defaultWeeklySchedule")

           
        }

        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

