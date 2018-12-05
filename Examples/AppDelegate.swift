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
    
    fileprivate final var observation: Observation?

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
        
//        let viewController = ModelView<City, UIAddressCityButton>(
//            model: Model(value: Taiwan.taipei),
//            bindedView: UIAddressCityButton()
//        )
//
//        viewController.bindedView?.touchUpInsideHandler = {
//
//            viewController.bindedView?.input.value = Taiwan.tainan
//
//        }
        
//        let viewController = ModelView<String, UIAddressPostalCodeTextField>(
//            model: Model(),
//            bindedView: UIAddressPostalCodeTextField()
//        )
        
//        observation = viewController.model?.storage.observe { change in
//
//            print(change.currentValue)
//
//        }
        
        let textField = UITextField()
        
        textField.placeholder = "Postal Code"
        
        let modelView = InteractableView(
            bindableView: UITextFieldContainerView(textField)
        )
        
        observation = modelView.model.observe { change in
         
            print(change)
            
        }
        
        let viewController = UIViewController()
        
        viewController.view.wrapSubview(modelView)
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
