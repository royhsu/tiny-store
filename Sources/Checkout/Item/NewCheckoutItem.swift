//
//  NewCheckoutItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/30.
//

// MARK: - NewCheckoutItem

public protocol NewCheckoutItem {
    
    var title: String { get }
    
    var price: Double { get }
    
    var quantityField: NewCheckoutQuantityField { get }
    
}

public struct NewCheckoutQuantityField: FormField {
    
    public var value: UInt?
    
    public let rules: [ AnyValidationRule<UInt> ]

    public let definition: FormFieldDefinition
    
    #warning("add validation rules.")
    public init(
        value: UInt? = nil,
        rules: [ AnyValidationRule<UInt> ] = [],
        definition: FormFieldDefinition = .required
    ) {
        
        self.value = value
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}

public struct NewCheckoutItemTemplate: Template {
    
    public struct Configuration: TemplateConfiguration {
        
        public enum Element {
            
            case title
            
        }
        
    }
    
    private let base: ConfigurableTemplate<NewCheckoutItem, Configuration>
    
    public init(
        storage: NewCheckoutItem,
        elements: [Configuration.Element]
    ) {
        
        self.base = ConfigurableTemplate(
            storage: storage,
            elements: elements
        )
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        base.registerView(
            UILabel.self,
            binding: { storage, label in
                
                label.numberOfLines = 0
                
                label.backgroundColor = .white
                
                label.text = "Title: \(storage.title)"
                
            },
            for: .title
        )
        
    }
    
    public var numberOfViews: Int { return base.numberOfViews }
    
    public func view(at index: Int) -> View { return base.view(at: index) }
    
}

