//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyStore

@UIApplicationMain
public final class AppDelegate: UIResponder {

    private final var model = TSModel<String>()
    
    private final var observation: Observation?
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {

//        observation = model.addObserver(self) { [weak self] delegate, change in
//
//            print("model", self?.model)
//
//            print("observer", delegate)
//
//            print("change", change)
//
//        }
//
//        model.value = "Hi"
        
        let viewController = UICheckoutController()
        
        window.rootViewController = viewController

        window.makeKeyAndVisible()

        return true

    }

}
