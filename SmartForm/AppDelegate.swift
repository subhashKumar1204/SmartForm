//
//  AppDelegate.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 14/02/21.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: DashboardViewController())
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true

        return true
    }
}
