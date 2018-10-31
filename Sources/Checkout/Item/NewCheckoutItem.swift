//
//  NewCheckoutItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/30.
//

// MARK: - NewCheckoutItem

public struct NewCheckoutItem {
    
    public let title = Observable<String?>()
    
    public var price: Double?
    
    public var quantity: UInt
    
    public init(
        title: String? = nil,
        price: Double? = nil,
        quantity: UInt = 0
    ) {
        
        self.price = price
        
        self.quantity = quantity
        
        self.title.value = title
        
    }
    
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

internal final class QuantityStepper: UIStepper {
    
    internal final var valueDidChange: ( (Double) -> Void )?
    
    internal override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepare()
        
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        prepare()
        
    }
  
    fileprivate final func prepare() {
        
        addTarget(
            self,
            action: #selector(changeValue),
            for: .valueChanged
        )
        
    }
    
    @objc
    public final func changeValue(_ sender: QuantityStepper) { valueDidChange?(value) }
    
}

public struct NewCheckoutItemTemplate: Template {
    
    private let base: UINewCheckoutItemView
    
    public init(
        title: String? = nil
    ) {
        
        let base = UIView.loadView(
            UINewCheckoutItemView.self,
            from: Bundle(for: UINewCheckoutItemView.self)
        )!
        
        base.titleLabel.text = title
        
        self.base = base
        
    }
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return base }
    
}
