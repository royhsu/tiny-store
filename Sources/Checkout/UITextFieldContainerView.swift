//
//  UITextFieldContainerView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/11/29.
//

// MARK: - UITextFieldContainerView

#warning("move into TinyKit")
public final class UITextFieldContainerView: UIView, UserInputable, ValueRenderable {
    
    private final var isLoaded = false
    
    public final var textField: UITextField? {
        
        willSet {
            
            guard isLoaded else { return }
            
            removeTextFieldTarget()
            
            textField?.removeFromSuperview()
            
        }
        
        didSet {
            
            guard
                isLoaded,
                let textField = textField
            else { return }
            
            wrapSubview(textField)
            
            addTextFieldTarget()
            
        }
        
    }
    
    public final var didReceiveUserInput: ( (String) -> Void )?
    
    public init(_ textField: UITextField? = nil) {
        
        self.textField = textField
        
        super.init(frame: .zero)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    private final func load() {
        
        isLoaded.toggle()
        
        if let textField = textField { wrapSubview(textField) }
        
        addTextFieldTarget()
        
    }
    
    private final func addTextFieldTarget() {
        
        textField?.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
    }
    
    private final func removeTextFieldTarget() {
        
        textField?.removeTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
    }
    
    @objc
    public final func textDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        didReceiveUserInput?(text)
        
    }
    
    public final func render(with text: String?) { textField?.text = text }
    
}
