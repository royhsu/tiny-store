//
//  CheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutViewController

public final class CheckoutViewController: ViewController {

    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?

    private final var _actionDispatcher: Optional< (Action) -> Void >

    private final var _errorHandler: Optional< (Error) -> Void >

    private final var _navigation: Optional< (Destination) -> Void >

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
                
                self._base.sections = sections
                
                self.asyncInvalidateLayout()
                
            case let .failure(error): self._errorHandler?(error)
                
            }
            
        }
        
    }
    
    public final override func viewDidLoad() {

        super.viewDidLoad()

        addChild(_base)

        view.wrapSubview(_base.view)

        _base.didMove(toParent: self)

        _base.layout = TableViewLayout()

        dispatchActions()

        handleErrors()

        reduceStorage()

    }

    fileprivate final func dispatchActions() {

        _base.setAction { [weak self] action in

            guard
                let self = self
            else { return }

            if let action = action as? CheckoutShippingAction {

                switch action {

                case let .updateValue(shipping):

                    self.form?.storage.setValue(
                        .shipping(shipping),
                        forKey: shipping.identifier
                    )

                case var .showCityPicker(shipping):

                    self._navigation?(
                        CheckoutDestination.cityPicker { city in
                            
                            shipping.cityField.value = city
                            
                            self.form?.storage.setValue(
                                .shipping(shipping),
                                forKey: shipping.identifier
                            )
                            
                            #warning("better to only reload the related sections.")
                            self.reduceStorage()

                        }
                    )
                    
                case var .showPostalCodePicker(shipping):
                    
                    #warning("delegate.")
                    shipping.postalCodeField.value = "1234"
                    
                    self.form?.storage.setValue(
                        .shipping(shipping),
                        forKey: shipping.identifier
                    )
                    
                    self.reduceStorage()

                }

                return

            }
            
            if let action = action as? CheckoutRecipientAction {
                
                switch action {
                    
                case let .updateValue(recipient):
                    
                    self.form?.storage.setValue(
                        .recipient(recipient),
                        forKey: recipient.identifier
                    )
                    
                case var .showPersonTitlePicker(recipient):
                    
                    #warning("delegate.")
                    recipient.personTitleField.value = "Mr."
                    
                    self.form?.storage.setValue(
                        .recipient(recipient),
                        forKey: recipient.identifier
                    )
                    
                    self.reduceStorage()
                    
                }
                
            }

        }

    }

    fileprivate final func asyncInvalidateLayout() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?._base.layout?.invalidate()
            
        }
        
    }
    
    fileprivate final func handleErrors() {

        _base.setError { error in

            #warning("TODO: error handling")
            print("\(error)")

        }

    }

    public final func navigate(
        _ navigation: @escaping (Destination) -> Void
    ) { _navigation = navigation }

}
