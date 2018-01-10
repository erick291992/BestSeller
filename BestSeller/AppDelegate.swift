//
//  AppDelegate.swift
//  BestSeller
//
//  Created by erick manrique on 1/9/18.
//  Copyright © 2018 erick manrique. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setting up window and intial view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: CategoriesViewController())
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        // get rid of black bar underneath navbar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        UINavigationBar.appearance().barTintColor = appBaseColor
        UINavigationBar.appearance().tintColor = navigationBarTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: navigationBarTitleTextColor]
        UINavigationBar.appearance().isTranslucent = false
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

private var firstLaunch : Bool = false

extension UIApplication{
    
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    
    static func isFirstLaunch() -> Bool {
        
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            firstLaunch = isFirstLaunch
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
        }
        return firstLaunch || isFirstLaunch
    }
    
    static func setupDefaultValues() {
        //setting defaults only on the first launch of the app
        if UIApplication.isFirstLaunch(){
            //set distance
            UserDefaults.standard.set(FilterKeyValues.Rank.rawValue, forKey: filterKey)
        }
    }
    
}

