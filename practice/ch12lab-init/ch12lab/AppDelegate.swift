//
//  AppDelegate.swift
//  ch12lab
//
//  Created by Jae Moon Lee on 2021/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("AppDelegate.didFinishLaunchingWithOptions")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("AppDelegate.configurationForConnecting")
        //return UISceneConfiguration(name: "jmlee Configuration", sessionRole: connectingSceneSession.role)
    
        let connectedScenes = UIApplication.shared.connectedScenes
        var name = "Default Configuration"
        if connectedScenes.count == 1{  // this is the second
            let cs = connectedScenes.first
            if cs?.session.configuration.name == "Default Configuration"{
                name = "Other Configuration"
            }
        }
        //        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        return UISceneConfiguration(name: name, sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print("AppDelegate.didDiscardSceneSessions")
    }


}

