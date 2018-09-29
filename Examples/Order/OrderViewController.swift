//
//  OrderViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - OrderViewController

import PatissierStore

public final class OrderViewController: ViewController, CheckoutOrderStep {
    
    private final let _base = CheckoutOrderViewController()
    
    public final var form: CheckoutForm {
        
        get { return _base.form }
        
        set { _base.form = newValue }
        
    }
    
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
        
        addChild(_base)
        
        view.wrapSubview(_base.view)
        
        _base.didMove(toParent: self)
        
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
    
    private final var orderCompletion: Optional< (Result<CheckoutOrder>) -> Void >
    
    public final func navigate(
        _ navigation: @escaping (Destination) -> Void
    ) { _base.navigate(navigation) }
    
    public final func setOrder(
        _ completion: @escaping (Result<CheckoutOrder>) -> Void
    ) { orderCompletion = completion }
    
    @objc
    public final func done(_ item: UIBarButtonItem) {
        
        do {
            
            let order = try form.export(Order.self)
            
            orderCompletion?(
                .success(order)
            )
            
        }
        catch {
            
            orderCompletion?(
                .failure(error)
            )
            
        }
        
    }
    
}
