//
//  AppDelegate.swift
//  WidgetDemo
//
//  Created by Z on 2020/9/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        guard let window = window else { return false }
        
        window.makeKeyAndVisible()
        window.backgroundColor = .red
        window.rootViewController = ViewController()
        
        return true
    }


    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print("点击了widget进来 url:\(url)")
        
        return true
    }
    
}

