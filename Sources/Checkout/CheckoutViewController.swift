//
//  CheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutViewController

import TinyStorage
import TinyKit

public final class CheckoutViewController: CollectionViewController
<
    MemoryCache<Int, String>,
    CheckoutSectionCollection,
    CheckoutSectionCollection
> {
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        storageReducer = { storage in
            
            return .init(
                sections: [
                    .shipping(
                        AnyTemplate(
                            Patissier.ShippingTemplate(
                                elements: [
                                    .header,
                                    .form
                                ]
                            )
                        )
                    )
                ]
            )
            
        }
        
    }
    
}
