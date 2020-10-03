import UIKit
import Flutter


import UserNotifications
import GoogleMaps
import FBSDKCoreKit
import Firebase
import FirebaseMessaging

@UIApplicationMain

class AppDelegate: FlutterAppDelegate , MessagingDelegate  {


  override func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


    UNUserNotificationCenter.current().delegate = self

    FirebaseApp.configure()
    
    
    
    if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
    
    
    application.registerForRemoteNotifications()
    Messaging.messaging().delegate = self
    
    GMSServices.provideAPIKey("AIzaSyDdQN_l3DKOGUV5wnTrYtW5brlAFjmhNTs")
    
    GeneratedPluginRegistrant.register(with: self)
    
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions:
        launchOptions
    )
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    }
    
    
    func application(application : UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
//        Messaging.messaging().apnsToken = deviceToken
//        Messaging.messaging().apnsToken = deviceToken as Data
        
        return ApplicationDelegate.shared.application(
            application,
            open: url,
            options: options
        )
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
  

}



