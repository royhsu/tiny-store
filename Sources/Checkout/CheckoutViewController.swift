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

public final class CheckoutViewController: ViewController {
    
    public final var shippingTemplateType: CheckoutShippingTemplate.Type?
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var _actionDispatcher: Optional< (Action) -> Void >
    
    private final var _errorHandler: Optional< (Error) -> Void >
    
    private final var _base = NewCollectionViewController()
    
    public final var storage: CheckoutStorage? {
        
        didSet {
            
            guard
                let storage = storage
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
    
    private typealias CheckoutStorageReducer = StorageReducer<CheckoutStorage, CheckoutSectionCollection>
    
    private final var storageReducer: CheckoutStorageReducer?
    
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
                    
                case let .newInput(input):
                    
                    switch input {
                        
                    case let .address(address):
                        
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
        
    }
    
    fileprivate final func handleErrors() {
        
        _base.setError { error in
            
            print("\(error)")
            
        }
        
    }
    
    public typealias CheckoutSectionCollection = [Template]
    
    #warning("memory leaks by pass function as the closure parameter?")
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
