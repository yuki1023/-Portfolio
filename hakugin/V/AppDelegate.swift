//
//  AppDelegate.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/06.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NCMB.setApplicationKey("cc9f2a720a2e183075446c26063b1745a471e25587dd802ed8736e4da8893800",
                               clientKey: "c2c4280f8fa5343cfe63e234e3cf2d65d067d7460157a4f959f4b2361ee115bb")
        
        let ud = UserDefaults.standard
                       if ud.object(forKey: "userName") == nil {
                           NCMBUser.enableAutomaticUser()
                           NCMBUser.automaticCurrentUser { (user, error) in
                               if error != nil {
                                   print(error)
                               } else {
                                   ud.set(user?.objectId, forKey: "userName")
                                   print(ud.object(forKey: "userName"))
                               }
                           }
                       }

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

