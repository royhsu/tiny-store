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

public enum TaiwanCity: City {
    
    case taipei
    
    case tainan
    
    case yunlin
    
    public var name: String {
        
        switch self {
            
        case .taipei: return "Taipei"
            
        case .tainan: return "Tainan"
            
        case .yunlin: return "Yunlin"
            
        }
        
    }
    
}

public enum TaiwanPostalCode: String, PostalCode {
    
    case daAnDistrict = "104"
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let viewController = ShippingDestinationEditorController(
            destination: [
                .postalCode(
                    InputableViewBinding(
                        model: Model(value: TaiwanPostalCode.daAnDistrict),
                        view: UIPostalCodeView<TaiwanPostalCode>()
                    )
                )
            ]
        )
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
