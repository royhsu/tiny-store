//
//  CheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutViewController

import TinyStorage
import TinyKit

extension String: CheckoutShipping { }

public final class CheckoutViewController: CollectionViewController< MemoryCache<Int, String> > {
    
    public final var shippingTemplateType: ShippingTemplate.Type { return PatissierShippingTemplate.self }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        storageReducer = { [unowned self] storage in

            return [
                CheckoutTemplate.shipping(
                    self.shippingTemplateType.init(
                        storage: "hello",
                        reducer: { storage in

                            return [
                                .header,
                                .form { action in
                                    
                                    switch action {
                                        
                                    case let .newInput(input):
                                        
                                        print(input)
                                        
                                    }
                                    
                                }
                            ]

                        }
                    )
                )
            ]
            
//            let redView = View()
//
//            redView.backgroundColor = .red
//
//            redView.translatesAutoresizingMaskIntoConstraints = false
//
//            redView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
//
//            let template: Template = [ redView ]
//
//            return [ template ]
            
        }
        
    }
    
}
