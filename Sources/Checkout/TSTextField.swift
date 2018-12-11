//
//  TSTextField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSTextField

@IBDesignable
open class TSTextField: UIControl, UITextFieldDelegate {

    private final let _nibView = UIView.loadView(
        TSTextFieldNibView.self,
        from: Bundle(for: TSTextFieldNibView.self)
    )!
    
    public final var shouldReturn: ( (TSTextField) -> Bool )?
    
    public final var textDidChange: ( (TSTextField) -> Void )?
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        wrapSubview(_nibView)
        
        _nibView.textField.delegate = self
        
        _nibView.textField.addTarget(
            self,
            action: #selector(editText),
            for: .editingChanged
        )
        
    }
    
    public final func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return shouldReturn?(self) ?? false
        
    }
    
    @discardableResult
    public final override func becomeFirstResponder() -> Bool { return _nibView.textField.becomeFirstResponder() }
    
    @objc
    public final func editText(_ textField: UITextField) { textDidChange?(self) }
    
}

public extension TSTextField {
    
    @IBInspectable
    public final var text: String? {
        
        get { return _nibView.textField.text }
        
        set { _nibView.textField.text = newValue }
        
    }
    
    @IBInspectable
    public final var textAlignment: NSTextAlignment {
        
        get { return _nibView.textField.textAlignment }
        
        set { _nibView.textField.textAlignment = newValue }
        
    }
    
    @IBInspectable
    public final var placeholder: String? {
        
        get { return _nibView.textField.placeholder }
        
        set { _nibView.textField.placeholder = newValue }
        
    }
    
    @IBInspectable
    public final var keyboardType: UIKeyboardType {
        
        get { return _nibView.textField.keyboardType }
    
        set {  _nibView.textField.keyboardType = newValue }
        
    }
    
    @IBInspectable
    public final var returnKeyType: UIReturnKeyType {
        
        get { return _nibView.textField.returnKeyType }
        
        set {  _nibView.textField.returnKeyType = newValue }
        
    }
    
}
