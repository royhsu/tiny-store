//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import PatissierStore
import TinyStorage
import TinyStore
import TinyKit
import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
    public final let checkoutViewController = CheckoutViewController()
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        checkoutViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done)
        )
        
        #warning("Use register mechanism instead.")
        checkoutViewController.recipientTemplateType = UICheckoutRecipientTemplate.self
        
        checkoutViewController.form = [
            .shipping(
                CheckoutShippingField(
                    style: UICheckoutShippingStyle.self,
                    address: "hello"
                )
            ),
            .recipient(
                CheckoutRecipientField(
                    firstName: "world"
                )
            )
        ]
        
        window.rootViewController = UINavigationController(rootViewController: checkoutViewController)
        
        window.makeKeyAndVisible()
        
        return true
            
    }
    
    @objc
    public final func done(_ item: UIBarButtonItem) {
        
        do {
        
            guard
                let results = try checkoutViewController.form?.validateAll()
            else { return }

            print("Done", results)
            
        }
        catch { print("\(error)") }
        
    }
    
}
