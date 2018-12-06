//
//  UIAddressPostalCodeTextField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - UIAddressPostalCodeTextField

public final class UIAddressPostalCodeTextField<P: PostalCode>: UIView, UserInputable, ValueRenderable {
    
    private final var _postalCode: P? {
        
        didSet { textFieldContainerView.render(with: _postalCode?.rawValue) }
        
    }
    
    public final var postalCode: P? {
        
        get { return _postalCode }
        
        set {
            
            _postalCode = newValue
            
            if let postalCode = postalCode { didReceiveUserInput?(postalCode) }
            
        }
        
    }
    
    public final var didReceiveUserInput: ( (_ postalCode: P) -> Void )?
    
    private final lazy var textFieldContainerView: UITextFieldContainerView = {
        
        let textField = UITextField()
        
        textField.placeholder = NSLocalizedString(
            "Postal Code",
            comment: ""
        )
        
        textField.textAlignment = .center
        
        textField.keyboardType = .numberPad
        
        return UITextFieldContainerView(textField)
        
    }()
    
    public init(postalCode: P? = nil) {
        
        self._postalCode = postalCode
        
        super.init(frame: .zero)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        wrapSubview(textFieldContainerView)
        
        textFieldContainerView.render(with: postalCode?.rawValue)
        
        textFieldContainerView.didReceiveUserInput = { [weak self] text in
            
            guard let self = self else { return }
            
            if let postalCode = P(rawValue: text) {
                
                self.postalCode = postalCode
                
            }
            else {
                
                self.postalCode = nil
                
                #warning("error handling. invalid input for a postal code.")
                
            }
            
        }
        
    }
    
    public final func render(with postalCode: P?) { _postalCode = postalCode }
    
}
