//
//  CheckoutOrderFillingViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutOrderFillingViewController

open class CheckoutOrderFillingViewController: ViewController {

    private final var _actionDispatcher: Optional< (Action) -> Void >

    private final var _errorHandler: Optional< (Error) -> Void >

    private final var _navigation: Optional< (Destination) -> Void >

    private final let base = CollectionViewController()

    public final var form: CheckoutForm = [] {

        didSet {

            storageReducer = Reducer(
                storage: form.storage,
                transform: { storage in
                    
                    let sections = storage.elements.map { _, element in element.template }
                    
                    return sections
                    
                }
            )

        }

    }

    private typealias Reducer = StorageReducer<CheckoutStorage, SectionCollection>

    private final var storageReducer: Reducer?

    fileprivate func reduceStorage() {
        
        storageReducer?.reduce(queue: .main) { [weak self] result in
            
            guard
                let self = self
            else { return }
            
            switch result {
                
            case let .success(sections):
                
                self.base.sections = sections
                
                self.asyncInvalidateLayout()
                
            case let .failure(error): self._errorHandler?(error)
                
            }
            
        }
        
    }
    
    open override func viewDidLoad() {

        super.viewDidLoad()

        addChild(base)

        view.wrapSubview(base.view)

        base.didMove(toParent: self)

        base.layout = TableViewLayout()

        dispatchActions()

        handleErrors()

        reduceStorage()

    }
    
    fileprivate final func dispatchActions() {

        base.setAction { [weak self] action in

            if let action = action as? CheckoutItemAction {
                
                self?.handleItemAction(action)
            
            }
            else if let action = action as? CheckoutShippingAction {

                self?.handleShippingAction(action)
                
            }
            else if let action = action as? CheckoutRecipientAction {
                
                self?.handleRecipientAction(action)
                
            }

        }

    }

    fileprivate final func asyncInvalidateLayout() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.base.layout?.invalidate()
            
        }
        
    }
    
    fileprivate final func handleItemAction(_ action: CheckoutItemAction) {
        
        switch action {
            
        case let .updateField(field):
            
            form.storage.setValue(
                .item(field),
                forKey: field.identifier
            )
            
        }
        
    }
    
    fileprivate final func handleShippingAction(_ action: CheckoutShippingAction) {
        
        switch action {
            
        case let .updateField(field):
            
            form.storage.setValue(
                .shipping(field),
                forKey: field.identifier
            )
            
        case var .showCityPicker(field):
            
            _navigation?(
                CheckoutDestination.cityPicker { city in
                    
                    field.cityField.value = city
                    
                    self.form.storage.setValue(
                        .shipping(field),
                        forKey: field.identifier
                    )
                    
                    #warning("better to only reload the related sections.")
                    self.reduceStorage()
                    
                }
            )
            
        case var .showPostalCodePicker(field):
            
            #warning("delegate.")
            field.postalCodeField.value = "1234"
            
            form.storage.setValue(
                .shipping(field),
                forKey: field.identifier
            )
            
            reduceStorage()
            
        }
        
    }
    
    fileprivate final func handleRecipientAction(_ action: CheckoutRecipientAction) {
        
        switch action {
            
        case let .updateField(field):
            
            form.storage.setValue(
                .recipient(field),
                forKey: field.identifier
            )
            
        case var .showPersonTitlePicker(field):
            
            #warning("delegate.")
            field.personTitleField.value = "Mr."
            
            form.storage.setValue(
                .recipient(field),
                forKey: field.identifier
            )
            
            reduceStorage()
            
        }
        
    }
    
    fileprivate final func handleErrors() {

        base.setError { error in

            #warning("TODO: error handling")
            print("\(error)")

        }

    }

    public final func navigate(
        _ navigation: @escaping (Destination) -> Void
    ) { _navigation = navigation }

}
