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
    
    public final var shippingTemplateType: CheckoutShippingTemplate.Type?
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var _actionDispatcher: Optional< (Action) -> Void >
    
    private final var _errorHandler: Optional< (Error) -> Void >
    
    private final var _base = CollectionViewController()
    
    public final var storage: CheckoutStorage? {
        
        didSet {
            
            guard
                let storage = storage
            else {
                
                storageReducer = nil

                return
                    
            }
            
            storageReducer = Reducer(
                storage: storage,
                reduction: reduce
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
                    
                    self.storage?.setValue(
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
    
    #warning("memory leaks by pass function as the closure parameter?")
    fileprivate final func reduce(storage: CheckoutStorage) -> SectionCollection {
            
        guard
            let shippingTemplateType = shippingTemplateType
        else { fatalError("Must provide a shipping template") }
        
        guard
            let recipientTemplateType = recipientTemplateType
        else { fatalError("Must provide a recipient template") }
        
        return storage.elements.map { _, element in
            
            switch element {
                
            case let .shipping(storage):
                
                return shippingTemplateType.init(
                    storage: storage,
                    reducer: { storage in
                        
                        return [
                            .header,
                            .form
                        ]
                        
                    }
                )
                
            case let .recipient(storage):
                
                return recipientTemplateType.init(
                    storage: storage,
                    reducer: { storage in
                        
                        return [
                            .header,
                            .form
                        ]
                        
                    }
                )
                
            }
            
        }
        
    }
    
}
