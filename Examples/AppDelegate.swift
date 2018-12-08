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
        
//        let stateBinding = RenderableViewBinding(
//            model: Model(value: TaiwanCity.taipei),
//            view: UIAdressStateButton()
//        )
//
//        stateBinding.view.cityPickerPresenter = { button in
//
//            print("Showing picker...")
//
//        }
//
//        let postalCodeBinding = InputableViewBinding(
//            model: Model(value: TaiwanPostalCode.daAnDistrict),
//            view: UIAddressPostalCodeTextField<TaiwanPostalCode>()
//        )
//
//        let line1Binding = InputableViewBinding(
//            model: Model(),
//            view: UIAddressLineTextField()
//        )
//
//        line1Binding.view.placeholder = "Line 1"
//
//        let line2Binding = InputableViewBinding(
//            model: Model(),
//            view: UIAddressLineTextField()
//        )
//
//        line2Binding.view.placeholder = "Line 2"
//
//        let viewController = ShippingDestinationEditorController(
//            destination: [
//                .state(stateBinding),
//                .postalCode(postalCodeBinding),
//                .line(line1Binding),
//                .line(line2Binding)
//            ]
//        )
        
        let viewController = TSShippingDestinationEditorController()

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            viewController.recipient.firstName.value = "Roy"

            viewController.recipient.lastName.value = "Hsu"
            
        }

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
