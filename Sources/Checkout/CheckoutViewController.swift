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

public enum CheckoutFormElement {

    case shipping(CheckoutShipping)
    
    case recipient(CheckoutRecipient)

}

#warning("ArrayStorage")
public final class CheckoutStorage: Storage {
    
    /// The base.
    private final var _elements: [CheckoutFormElement]
    
    private enum State {
        
        case initial, loading, loaded
        
    }
    
    private final var state: State = .initial
    
    private final let changes: Observable< AnyCollection< StorageChange<Int, CheckoutFormElement> > > = Observable()
    
    public init(
        elements: [CheckoutFormElement] = []
    ) { self._elements = elements }
    
    public final var isLoaded: Bool { return (state == .loaded) }
    
    public final func load(
        completion: (
            (Result< AnyStorage<Int, CheckoutFormElement> >) -> Void
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
    
    public final func value(forKey key: Int) -> CheckoutFormElement? { return _elements[key] }
    
    public final func setValue(
        _ value: CheckoutFormElement?,
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
    
    public final var elements: AnyCollection< (key: Int, value: CheckoutFormElement) > {
        
        return AnyCollection(
            _elements.enumerated().map { ($0.offset, $0.element) }
        )
        
    }
    
    public final func observe(
        _ observer: @escaping (_ change: ObservedChange< AnyCollection< StorageChange<Int, CheckoutFormElement> > >) -> Void
    )
    -> Observation { return changes.observe(observer) }
    
}

//public final class CheckoutStorageReducer {
//
//    public typealias CheckoutSectionCollection = [CheckoutTemplate]
//
//    public final var storage: CheckoutStorage { return reducer.storage }
//
//    private final let reducer: StorageReducer<CheckoutStorage, CheckoutSectionCollection>
//
//    public init(
//        storage: CheckoutStorage,
//        shippingTemplateType: CheckoutShippingTemplate.Type?,
//        recipientTemplateType: CheckoutRecipientTemplate.Type?
//    ) {
//
//        self.reducer = StorageReducer(
//            storage: storage,
//            reduction:
//
//            }
//        )
//
//    }
//
//    public final func reduce(
//        queue: DispatchQueue = .global(qos: .background),
//        completion: @escaping ( Result<CheckoutSectionCollection> ) -> Void
//    ) {
//
//        reducer.reduce(
//            queue: queue,
//            completion: completion
//        )
//
//    }
//
//}

#warning("use composition instead of inheritance.")
public final class CheckoutViewController: NewCollectionViewController {
    
    #warning("Shuold make form conform to a dedicated storage.")
//    public final var form = CheckoutForm() {
//
//        willSet { form.errors = errors }
//
//    }
    
    public final var shippingTemplateType: CheckoutShippingTemplate.Type?
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var observations: [Observation] = []
    
    private typealias CheckoutStorageReducer = StorageReducer<CheckoutStorage, CheckoutSectionCollection>
    
    public final var storage: CheckoutStorage? {
        
        didSet {
        
            guard
                let storage =  storage
            else {
                
                storageReducer = nil
                
                return
                    
            }
            
            storageReducer = CheckoutStorageReducer(
                storage: storage,
                reduction: reduce
            )
            
        }
        
    }
    
    private final var storageReducer: CheckoutStorageReducer?
    
//    fileprivate func loadStorage() {
//
//        storage?.load { [weak self] result in
//
//            switch result {
//
//            case let .success(storage):
//
//                DispatchQueue.main.async {
//
//                    self?.layout?.invalidate()
//
//                }
//
//            case let .failure(error): self?.errors.value = error
//
//            }
//
//        }
//
//    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        form.errors = errors
        
//        observations.append(
//            actions.observe { [unowned self] change in
//
//                if let action = change.currentValue as? CheckoutShippingAction {
//
//                    switch action {
//
//                    case let .newInput(input):
//
//                        switch input {
//
//                        case let .address(address):
//
//                            self.storage?.setValue(
//                                .shipping(
//                                    .address(address)
//                                ),
//                                forKey: address.identifier
//                            )
//
//                        }
//
//                    }
//
//                    return
//
//                }
//
//            }
//        )
        
//        observations.append(
//            errors.observe { change in
//
//                guard
//                    let error = change.currentValue
//                else { return }
//
//                #warning("TODO: delegating errors.")
//                print("\(error)")
//
//            }
//        )
        
        layout = TableViewLayout()

        storageReducer?.reduce(queue: .main) { [weak self] result in
            
            guard
                let self = self
            else { return }
            
            switch result {
                
            case let .success(sections):
                
                self.sections = sections
                
                self.layout?.invalidate()
                
            case let .failure(error):
                
                #warning("error handling")
                print("\(error)")
                
            }
            
        }
        
    }
    
    public typealias CheckoutSectionCollection = [Template]
    
    fileprivate final func reduce(storage: CheckoutStorage) -> CheckoutSectionCollection {
            
        guard
            let shippingTemplateType = shippingTemplateType
        else { fatalError("Must provide a shipping template") }
        
        guard
            let recipientTemplateType = recipientTemplateType
        else { fatalError("Must provide a recipient template") }
        
        return storage.elements.map { (key, element) in
            
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
                
            case let .recipient(storage):
                
                return CheckoutTemplate.recipient(
                    recipientTemplateType.init(
                        storage: storage,
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
        
    }
    
}
