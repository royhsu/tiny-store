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
    
    private final var observation: Observation?
    
    private final let binding: InputableViewBinding<UITextFieldContainerView> = {
        
        let textField = UITextField()
        
        textField.placeholder = "Postal Code"
        
        return InputableViewBinding(
            model: Model(),
            view: UITextFieldContainerView(textField)
        )
        
    }()

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
        
//        observation = binding.model.observe { change in
//
//            print(change)
//
//        }
//
//        let viewController = UIViewController()
//
//        viewController.view.wrapSubview(binding.view!)

        let item = CheckoutApparelItem(isSelected: true, title: "Hi", color: "white", size: "XL", price: 10.0, quantity: 1)
        
        let viewController = CheckoutCartViewController(
            cart: [
                .item(
                    UICheckoutCartItemViewController(item)
                )
            ]
        )
        
        observation = item.quantity.observe { change in
         
            print(change)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            item.title.value = "Cool"
            
            item.size.value = "S"
            
        }
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
