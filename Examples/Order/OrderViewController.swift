//
//  OrderViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - OrderViewController

import PatissierStore

public final class OrderViewController: CheckoutOrderViewController, CheckoutOrderStep {
    
    public init() {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done)
        )
        
        navigate { destination in
            
            if let destination = destination as? CheckoutDestination {
                
                switch destination {
                    
                case let .cityPicker(completion):
                    
                    completion(Taiwan.taipei)
                    
                }
                
                return
                
            }
            
        }
        
    }
    
    private final var _makeOrder: Optional< (Result<CheckoutOrder>) -> Void >
    
    public final func makeOrder(
        _ completion: @escaping (Result<CheckoutOrder>) -> Void
    ) { _makeOrder = completion }
    
    @objc
    public final func done(_ item: UIBarButtonItem) {
        
        do {
            
            let order = try form.export(Order.self)
            
            _makeOrder?(
                .success(order)
            )
            
        }
        catch {
            
            _makeOrder?(
                .failure(error)
            )
            
        }
        
    }
    
}
