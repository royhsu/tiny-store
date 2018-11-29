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
        
        let viewController = ModelViewController<City, UIAddressCityView>(
            model: Model(value: Taiwan.taipei),
            bindedView: UIAddressCityView()
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            viewController.bindedView?.input.value = Taiwan.tainan

            
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {

            viewController.model?.storage.value = Taiwan.yunlin

        }
        
//        let viewController = UIAddressActionButtonController()
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
