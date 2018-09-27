//
//  CheckoutStorage.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/26.
//

// MARK: - CheckoutStorage

#warning("TODO: make a generic ArrayStorage.")
internal final class CheckoutStorage: Storage, ExpressibleByArrayLiteral {
    
    internal typealias Element = (key: UUID, value: CheckoutField)
    
    /// The base.
    private final var _base: [Element]
    
    private enum State {
        
        case initial, loading, loaded
        
    }
    
    private final var state: State = .initial
    
    private typealias Change = StorageChange<UUID, CheckoutField>
    
    private typealias Changes = AnyCollection<Change>
    
    private final let changes: Observable<Changes> = Observable()
    
    internal init(
        elements: [CheckoutField] = []
    ) {
        
        self._base = elements.map { element in
            
            return (
                element.identifier,
                element
            )
            
        }
        
    }
    
    internal convenience init(arrayLiteral elements: CheckoutField...) { self.init(elements: elements) }
    
    internal final var isLoaded: Bool { return (state == .loaded) }
    
    internal final func load(
        completion: (
            (Result< AnyStorage<UUID, CheckoutField> >) -> Void
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
    
    internal final func value(forKey key: UUID) -> CheckoutField? {
        
        return _base.first { $0.key == key }?.value
        
    }
    
    internal final func setValue(
        _ value: CheckoutField?,
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
    
    internal final func removeAll() { _base.removeAll() }
    
    internal final var count: Int { return _base.count }
    
    internal final var elements: AnyCollection<Element> { return AnyCollection(_base) }
    
    internal final func validateAll() throws -> AnyCollection<CheckoutResult> {
    
        let results = try _base.map { try $0.value.validate() }
        
        return AnyCollection(results)
    
    }
    
    internal final func observe(
        _ observer: @escaping (
            _ change: ObservedChange<
                AnyCollection< StorageChange<UUID, CheckoutField> >
            >
        )
        -> Void
    )
    -> Observation { return changes.observe(observer) }
    
}

