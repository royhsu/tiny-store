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

extension String: CheckoutRecipient { }

public enum FormElement {

    case shipping(CheckoutShipping)

}
//
//public struct DefaultShippingAddress: CheckoutShippingAddress {
//
//
//    public var address: String
//
//    public init(
//        address: String
//        ) { self.address = address }
//
//}
//
//
//public struct DefaultCheckoutShipping: CheckoutShipping {
//
//
//}

#warning("ArrayStorage")
public final class CheckoutStorage: Storage {
    
    /// The base.
    private final var _elements: [FormElement]
    
    private enum State {
        
        case initial, loading, loaded
        
    }
    
    private final var state: State = .initial
    
    private final let changes: Observable< AnyCollection< StorageChange<Int, FormElement> > > = Observable()
    
    public init(
        elements: [FormElement] = []
    ) { self._elements = elements }
    
    public final var isLoaded: Bool { return (state == .loaded) }
    
    public final func load(
        completion: (
            (Result< AnyStorage<Int, FormElement> >) -> Void
        )?
    ) {
       
        let isFirstLoading = (state == .initial)
        
        if isFirstLoading {
        
            state = .loading
            
            DispatchQueue.global(qos: .background).async { [weak self] in
                
                guard
                    let self = self
                else { return }
                
                defer { self.state = .loaded }
                
                let changes = self.elements.map(StorageChange.init)
                
                self.changes.value = AnyCollection(changes)
                
                completion?(
                    .success(
                        AnyStorage(self)
                    )
                )
                
            }
            
        }
        else {
            
            if state == .loading { return }
            
            state = .loading
            
            DispatchQueue.global(qos: .background).async { [weak self] in
             
                guard
                    let self = self
                else { return }
                
                completion?(
                    .success(
                        AnyStorage(self)
                    )
                )
                
            }
            
        }
        
    }
    
    public final func value(forKey key: Int) -> FormElement? { return _elements[key] }
    
    public final func setValue(
        _ value: FormElement?,
        forKey key: Int
    ) {
        
        guard
            let value = value
        else { fatalError("Setting the nil value is not allowed.") }
        
        _elements[key] = value
        
        changes.value = AnyCollection(
            [
                StorageChange(
                    key: key,
                    value: value
                )
            ]
        )
        
    }
    
    public final func removeAll() { _elements.removeAll() }
    
    public final var count: Int { return _elements.count }
    
    public final var elements: AnyCollection< (key: Int, value: FormElement) > {
        
        return AnyCollection(
            _elements.enumerated().map { ($0.offset, $0.element) }
        )
        
    }
    
    public final func observe(
        _ observer: @escaping (_ change: ObservedChange< AnyCollection< StorageChange<Int, FormElement> > >) -> Void
    )
    -> Observation { return changes.observe(observer) }
    
}

public final class CheckoutViewController: CollectionViewController< CheckoutStorage > {
    
    #warning("Shuold make form conform to a dedicated storage.")
//    public final var form = CheckoutForm() {
//
//        willSet { form.errors = errors }
//
//    }
    
    public final var shippingTemplateType: CheckoutShippingTemplate.Type?
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var observations: [Observation] = []
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        form.errors = errors
        
        observations.append(
            actions.observe { [unowned self] change in
                
                if let action = change.currentValue as? CheckoutShippingAction {
                    
                    switch action {
                        
                    case let .newInput(input):
                        
                        switch input {
                            
//                        case let .city(key, city): print(city)
                            
//                        case let .postalCode(key, postalCode): print(postalCode)
                            
                        case let .address(address):
//
//                            guard
//                                case var .shipping(storage)? = self.storage?.value(forKey: address.identifier)
//                            else { return }
                            
//                            address.text = address
                            
                            self.storage?.setValue(
                                .shipping(
                                    .address(address)
                                ),
                                forKey: address.identifier
                            )

                        }
                        
                    }
                    
                    return
                    
                }
                
            }
        )
        
        observations.append(
            errors.observe { change in
                
                guard
                    let error = change.currentValue
                else { return }
                
                #warning("TODO: delegating errors.")
                print("\(error)")
                
            }
        )
        
        storageReducer = { [unowned self] storage in
            
            guard
                let shippingTemplateType = self.shippingTemplateType
            else { fatalError("Must provide a shipping template") }
            
//            guard
//                let recipientTemplateType = self.recipientTemplateType
//            else { fatalError("Must provide a recipient template") }

            let templates: [Template] = storage.elements.map { (key, element) in
             
                switch element {
                    
                case let .shipping(storage):
                    
                    return CheckoutTemplate.shipping(
                        shippingTemplateType.init(
                            storage: [ storage ],
                            reducer: { storage in
                                
                                return [
                                    .header,
                                    .form
                                ]
                                
                            }
                        )
                    )
                    
                }
                
            }
            
//            templates.append(
//                CheckoutTemplate.recipient(
//                    recipientTemplateType.init(
//                        storage: "recpient",
//                        reducer: { storage in
//
//                            return [
//                                .header,
//                                .form
//                            ]
//
//                        }
//                    )
//                )
//            )
//
            return templates
            
        }
        
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
