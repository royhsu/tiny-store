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

    public final let window = UIWindow(frame: UIScreen.main.bounds)

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
//        let viewController = UICheckoutController()
        
        enum Taiwan: City {
            
            case taipei
            
            case tainan
            
            case yunlin
            
            var name: String {
                
                switch self {
                    
                case .taipei: return "Taipei"
                    
                case .tainan: return "Tainan"
                    
                case .yunlin: return "Yunlin"

                }
                
            }
            
        }
        
        let viewController = ModelViewController<City, UIAddressCityButton>(
            model: Model(value: Taiwan.taipei),
            bindedView: UIAddressCityButton()
        )
        
        viewController.bindedView?.touchUpInsideHandler = {
            
            viewController.bindedView?.input.value = Taiwan.tainan
            
        }
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
