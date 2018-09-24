//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyStorage
import TinyStore
import TinyKit
import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let checkoutViewController = CheckoutViewController()
        
        checkoutViewController.layout = TableViewLayout()
        
        let cache: MemoryCache = [
            0: "hello"
        ]
        
        checkoutViewController.storage = cache
        
        window.rootViewController = UINavigationController(rootViewController: checkoutViewController)
        
        window.makeKeyAndVisible()
        
        return true
            
    }
    
}
