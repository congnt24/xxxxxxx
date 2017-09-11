//
//  AppDelegate.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/18/17.
//  Copyright © 2017 cong. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import FBSDKCoreKit
import GoogleSignIn
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {



    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)

        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)

        return googleDidHandle || facebookDidHandle
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //facebook auth
        // Initialize sign-in

//        FirebaseAuthHelper.configure()
//        FBSDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
      Fabric.with([Crashlytics.self])
        let _ = AlemuaApi()
        let _ = RaoVatService()
        //SOcket io
        let _ = SocketIOHelper()
        GoogleMapHelper.configure()
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
//        Prefs.apiToken = "4fIVqGZPGQQakv7FBlyzUs671jzerg422UZrP2t4trl761Tekdngg6DSZoe8"
//        Prefs.userIdClient = 2
//        Prefs.userId = 2
//        Prefs.apiToken = "ZyyGgYSVi0mTAVDhkVPL6W02DNTU1hY3zB6Ym7odm2rRv8QWq9pIdfFyOJFJ"
//        Prefs.userIdClient = 10
//        Prefs.isUserLogged = true
        //setup notification

        FirebaseApp.configure()


        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        // [END register_for_notifications]



        // Initialize sign-in
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "259311042399-kj2fts3n54g1keqmobkporpm3h8b2v0v.apps.googleusercontent.com"
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        return true
    }

    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) { if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID1: \(messageID)")
    }

    // Print full message.
    print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID2: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")

        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
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
        SocketIOHelper.shared.disconnectToSocketIO()
        SocketIOHelper.shared.clearAllSubscribe()
    }


}

extension AppDelegate {
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            let photo = user.profile.imageURL(withDimension: 100)


            let req = FacebookRequest()
            req.email = (email as? String) ?? ""
            req.name = (name as? String) ?? ""
            req.facebookId = userId
            req.photo = (photo as? String) ?? ""
            LoginViewController.shared.sendToServer(data: req)
        } else {
            print("\(error.localizedDescription)")
        }
    }
}




// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID3: \(messageID)")
        }
        let aps = userInfo["aps"] as! [String: AnyObject]
        // Print full message.
        // Change this to your preferred presentation option
        completionHandler([.alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID4: \(messageID)")
        }
        let aps = userInfo["aps"] as! [String: AnyObject]
        // Print full message.

//        if let vibrate = userInfo["gcm.notification.vibrate"] as? NSNumber {
//            print(vibrate)
//        }
        print(aps)
        if let vibrate = userInfo["gcm.notification.vibrate"] as? String {
            print("vibrate")
            print(vibrate)
            if let sound = aps["sound"] as? String {
                print("sound")
                print(sound)
                if vibrate == "0" {
                    HomeCoordinator.sharedInstance.showChatScreen(data: sound)
                } else {
                    print(sound)
                    print("sound \(type(of: sound))")
                    switch sound {
                    case "1":
                        HomeCoordinator.sharedInstance.showOrderScreen(1)
                            break
                    case "2":
                        HomeCoordinator.sharedInstance.showDeliveryScreen(2)
                        break
                    case "3":
                        HomeCoordinator.sharedInstance.showDeliveryScreen(3)
                        break
                    case "4":
                        HomeCoordinator.sharedInstance.showDeliveryScreen(4)
                        break
                    default:
                        HomeCoordinator.sharedInstance.showDeliveryScreen(5)
                        break
                    }

                }
            }
        }
        //        if vibrate == 0 {
//            HomeCoordinator.sharedInstance.showChatScreen(friend:)
//        }
//        if vibrate == 1 {
//            switch sound {
//            case 1:
        //User nhận được thông báo báo giá của người gửi(Sang màn 5.1)

//                break
//            case 2:
//                //Shipper nhận được thông báo đống ý báo giá của user(Sang màn 11)
//                break
//            case 3:
//                //Shipper nhận được thông báo hủy đơn hàng của user(Sang màn 11.2)
//
//                break
//            case 4:
//                //Shipper nhận được thông báo đơn hàng thành công của user(Sang màn 11.1)
//
//                break
//            default:
//                //User nhận được thông báo nhận được tiền chuyển khoản từ admin(Sang màn 9.1)
//
//                break
//            }
//        }

        //handle onclick notification

//        HomeCoordinator.sharedInstance.show

        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        Prefs.firebaseToken = fcmToken
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}

