//
//  CheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutViewController

import TinyCore
import TinyStorage
import TinyKit
import TinyValidation

public final class CheckoutViewController: ViewController {
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var _actionDispatcher: Optional< (Action) -> Void >
    
    private final var _errorHandler: Optional< (Error) -> Void >
    
    private final var _base = CollectionViewController()
    
    public final var form: CheckoutForm? {
        
        didSet {
            
            guard
                let storage = form?.storage
            else {
                
                storageReducer = nil

                return
                    
            }
            
            storageReducer = Reducer(
                storage: storage,
                reduction: { storage in
                    
                    return storage.elements.map { _, element in
                        
                        switch element {
                            
                        case let .shipping(field): return field.style.apply(to: field)
                            
                        case let .recipient(field): return field.style.apply(to: field)
                            
                        }
                        
                    }
                }
            )
            
        }
        
    }
    
    private typealias Reducer = StorageReducer<CheckoutStorage, SectionCollection>
    
    private final var storageReducer: Reducer?
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(_base)
        
        view.wrapSubview(_base.view)
        
        _base.didMove(toParent: self)
        
        _base.layout = TableViewLayout()
        
        dispatchActions()
        
        handleErrors()
        
        storageReducer?.reduce(queue: .main) { [weak self] result in
            
            guard
                let self = self
            else { return }
            
            switch result {
                
            case let .success(sections):
                
                self._base.sections = sections
                
                self._base.layout?.invalidate()
                
            case let .failure(error): self._errorHandler?(error)
                
            }
            
        }
        
    }
    
    fileprivate final func dispatchActions() {
        
        _base.setAction { [weak self] action in
            
            guard
                let self = self
            else { return }
            
            if let action = action as? CheckoutShippingAction {
                
                switch action {
                    
                case let .newInput(shipping):
                    
                    self.form?.storage.setValue(
                        .shipping(shipping),
                        forKey: shipping.identifier
                    )
                    
                }
                
                return
                
            }
            
        }
        
    }
    
    fileprivate final func handleErrors() {
        
        _base.setError { error in
            
            #warning("TODO: error handling")
            print("\(error)")
            
        }
        
    }
    
}
