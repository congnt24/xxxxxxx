//
//  AppDelegate.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/18/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        let facebookDidHandle = SDKApplicationDelegate.shared.application(app, open: url, options: options)
//        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
//                                                                sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                                                annotation: [:])
//        return googleDidHandle || facebookDidHandle
//    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //facebook auth
//        FirebaseAuthHelper.configure()
//        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        AlemuaApi()
        //keyboard
        IQKeyboardManager.sharedManager().enable = true
        //init coordinator
        let navigation = UINavigationController()
        navigation.navigationBar.isHidden = true
//        navigation.navigationBar.isTranslucent = false
        let appCoor = AppCoordinator(navigation, window)
        appCoor.start(nil)
        window?.rootViewController = navigation
        print(Prefs.apiToken)
        print(Prefs.userId)
        Prefs.apiToken = "4fIVqGZPGQQakv7FBlyzUs671jzerg422UZrP2t4trl761Tekdngg6DSZoe8"
        Prefs.userIdClient = 2
//        Prefs.userId = 2
//        Prefs.apiToken = "ZyyGgYSVi0mTAVDhkVPL6W02DNTU1hY3zB6Ym7odm2rRv8QWq9pIdfFyOJFJ"
//        Prefs.userIdClient = 10
//        Prefs.isUserLogged = false
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

