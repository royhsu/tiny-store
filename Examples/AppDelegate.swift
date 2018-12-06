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
        
        enum TaiwanPostalCode: String, PostalCode {
            
            case daAnDistrict = "104"
            
        }

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
