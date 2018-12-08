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
    
    public final var model = TSModel<String>()

    public final let window = UIWindow(frame: UIScreen.main.bounds)

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        do {
        
            let data = try JSONSerialization.data(
                withJSONObject: [
                    "recipient": [
                        "firstName": "Roy",
                        "lastName": "Hsu"
                    ]
                ]
            )
            
            let decoder = JSONDecoder()
            
            let viewController = try decoder.decode(
                TSShippingDestinationEditorController.self,
                from: data
            )
        
            viewController.addressStateHandler = { _ in print("State picker...") }
            
            viewController.addressCityHandler = { _ in print("City picker...") }
            
            viewController.view.backgroundColor = .white
            
            let keyboardViewController = UIKeyboardController()
            
            keyboardViewController.setContentViewController(
                viewController,
                animated: true
            )
            
            window.rootViewController = keyboardViewController
            
            window.makeKeyAndVisible()
            
        }
        catch { print("\(error)") }

        return true

    }

}

class LabelViewController: UIViewController {
    
    let label1 = UILabel()
    
    let label2 = UILabel()
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        label1.textAlignment = .center
        
        label2.textAlignment = .center
        
        view.backgroundColor = .white
        
        view.wrapSubview(stackView)
        
        stackView.axis = .vertical
        
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(label1)
        
        stackView.addArrangedSubview(label2)
        
    }
    
}
