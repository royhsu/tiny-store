//
//  UIPostalCodeView.swift
//  TinyStore iOS
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - UIPostalCodeView

public final class UIPostalCodeView<P: PostalCode>: UIView, UserInputable, ValueRenderable {
    
    private final var _postalCode: P? {
        
        didSet { textFieldContainerView.render(with: _postalCode?.rawValue) }
        
    }
    
    public final var postalCode: P? {
        
        get { return _postalCode }
        
        set {
            
            _postalCode = newValue
            
            if let postalCode = postalCode {
                
                didReceiveUserInput?(postalCode)
                
            }
            
        }
        
    }
    
    public final var didReceiveUserInput: ( (P) -> Void )?
    
    private final lazy var textFieldContainerView: UITextFieldContainerView = {
        
        let textField = UITextField()
        
        textField.placeholder = NSLocalizedString(
            "Postal Code",
            comment: ""
        )
        
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
        
        textFieldContainerView.didReceiveUserInput = { text in
            
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
