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
public final class CheckoutStorage: Storage, ExpressibleByArrayLiteral {
    
    public typealias Element = (key: UUID, value: CheckoutElement)
    
    /// The base.
    private final var _base: [Element]
    
    private enum State {
        
        case initial, loading, loaded
        
    }
    
    private final var state: State = .initial
    
    private typealias Change = StorageChange<UUID, CheckoutElement>
    
    private typealias Changes = AnyCollection<Change>
    
    private final let changes: Observable<Changes> = Observable()
    
    public init(
        elements: [CheckoutElement] = []
    ) {
        
        self._base = elements.map { element in
            
            return (
                element.identifier,
                element
            )
            
        }
        
    }
    
    public convenience init(arrayLiteral elements: CheckoutElement...) { self.init(elements: elements) }
    
    public final var isLoaded: Bool { return (state == .loaded) }
    
    public final func load(
        completion: (
            (Result< AnyStorage<UUID, CheckoutElement> >) -> Void
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
                
                let changes = self._base.map(Change.init)
                
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
    
    public final func value(forKey key: UUID) -> CheckoutElement? {
        
        return _base.first { $0.key == key }?.value
        
    }
    
    public final func setValue(
        _ value: CheckoutElement?,
        forKey key: UUID
    ) {
        
        guard
            let value = value
        else { fatalError("Setting the nil value is not allowed.") }
        
        guard
            let index = _base.index(
                where: { $0.key == key }
            )
        else { fatalError("CANNOT find the matched value for key: \(key).") }
        
        _base[index] = (key, value)
        
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
    
    public final var elements: AnyCollection<Element> { return AnyCollection(_base) }
    
    public final func observe(
        _ observer: @escaping (
            _ change: ObservedChange<
                AnyCollection< StorageChange<UUID, CheckoutElement> >
            >
        )
        -> Void
    )
    -> Observation { return changes.observe(observer) }
    
}

