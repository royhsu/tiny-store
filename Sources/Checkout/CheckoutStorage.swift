//
//  CheckoutStorage.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/26.
//

// MARK: - CheckoutStorage

import TinyCore
import TinyStorage

#warning("TODO: make a generic ArrayStorage.")
public final class CheckoutStorage: Storage {
    
    /// The base.
    private final var _base: [CheckoutElement]
    
    private enum State {
        
        case initial, loading, loaded
        
    }
    
    private final var state: State = .initial
    
    private final let changes: Observable< AnyCollection< StorageChange<Int, CheckoutElement> > > = Observable()
    
    public init(
        elements: [CheckoutElement] = []
    ) { self._base = elements }
    
    public final var isLoaded: Bool { return (state == .loaded) }
    
    public final func load(
        completion: (
            (Result< AnyStorage<Int, CheckoutElement> >) -> Void
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
    
    public final func value(forKey key: Int) -> CheckoutElement? { return _base[key] }
    
    public final func setValue(
        _ value: CheckoutElement?,
        forKey key: Int
    ) {
        
        guard
            let value = value
        else { fatalError("Setting the nil value is not allowed.") }
        
        _base[key] = value
        
        changes.value = AnyCollection(
            [
                StorageChange(
                    key: key,
                    value: value
                )
            ]
        )
        
    }
    
    public final func removeAll() { _base.removeAll() }
    
    public final var count: Int { return _base.count }
    
    public final var elements: AnyCollection< (key: Int, value: CheckoutElement) > {
        
        return AnyCollection(
            _base.enumerated().map { ($0.offset, $0.element) }
        )
        
    }
    
    public final func observe(
        _ observer: @escaping (_ change: ObservedChange< AnyCollection< StorageChange<Int, CheckoutElement> > >) -> Void
    )
    -> Observation { return changes.observe(observer) }
    
}

