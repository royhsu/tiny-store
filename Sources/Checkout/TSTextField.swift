//
//  TSTextField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSTextField

@IBDesignable
open class TSTextField: UIView {

    private final let _nibView = UIView.loadView(
        TSTextFieldNibView.self,
        from: Bundle(for: TSTextFieldNibView.self)
    )!
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() { wrapSubview(_nibView) }
    
}

public extension TSTextField {
    
    @IBInspectable
    public final var text: String? {
        
        get { return _nibView.textField.text }
        
        set { _nibView.textField.text = newValue }
        
    }
    
    @IBInspectable
    public final var placeholder: String? {
        
        get { return _nibView.textField.placeholder }
        
        set { _nibView.textField.placeholder = newValue }
        
    }
    
}
