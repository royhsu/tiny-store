//
//  UICheckoutStepper.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - UICheckoutStepper

public final class UICheckoutStepper: UIView {
    
    @IBOutlet
    private final var decreaseButton: UIButton! {
        
        didSet {
            
            decreaseButton.addTarget(
                self,
                action: #selector(descrease),
                for: .touchUpInside
            )
            
            decreaseButton.tintColor = .black
            
        }
        
    }
    
    @IBOutlet
    private final var increaseButton: UIButton! {
        
        didSet {
            
            increaseButton.addTarget(
                self,
                action: #selector(increase),
                for: .touchUpInside
            )
            
            increaseButton.tintColor = .black
            
        }
        
    }
    
    @IBOutlet
    private final var valueTextField: UITextField! {
        
        didSet {
            
            valueTextField.borderStyle = .none
            
            valueTextField.font = .preferredFont(forTextStyle: .body)
            
            valueTextField.text = "\(_value)"
            
            valueTextField.keyboardType = .numberPad
            
        }
        
    }
    
    public final var _minimumValue: Int = 0
    
    public final var minimumValue: Int {
        
        get { return _minimumValue }
        
        set {
            
            _minimumValue = min(
                newValue,
                maximumValue
            )
            
        }
        
    }
    
    public final var _maximumValue: Int = 10
    
    public final var maximumValue: Int {
        
        get { return _maximumValue }
        
        set {
            
            _maximumValue = max(
                minimumValue,
                newValue
            )
            
        }
        
    }
    
    private final var _value: Int = 1 {
        
        didSet {
            
            if _value == oldValue { return }
            
            valueTextField.text = "\(_value)"
            
        }
        
    }
    
    public final var value: Int {
        
        get { return _value }
        
        set {
            
            if (minimumValue...maximumValue).contains(newValue) {
            
                _value = newValue
                
            }
            
            decreaseButton.isEnabled = (newValue != minimumValue)
            
            increaseButton.isEnabled = (newValue != maximumValue)
            
        }
        
    }
    
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        layer.borderColor = UIColor.black.cgColor
        
        layer.borderWidth = 0.5
        
    }
    
    @objc
    public final func descrease(sender: Any) { value -= 1 }
    
    @objc
    public final func increase(sender: Any) { value += 1 }
    
}
