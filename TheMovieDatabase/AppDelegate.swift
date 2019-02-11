//
//  AppDelegate.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/8/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    var mainNavigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.mainNavigationController = UINavigationController()

        if let mainNavigationController = self.mainNavigationController {
            mainNavigationController.delegate = self
            mainNavigationController.setNavigationBarHidden(true, animated:false)
            mainNavigationController.pushViewController(MainViewController(), animated:true)

            self.window = UIWindow(frame: UIScreen.main.bounds)
            if let window = self.window {
                window.rootViewController = mainNavigationController
                window.makeKeyAndVisible()
            }
        }

        return true
    }
}
