//
//  UITextFieldController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/11/29.
//

// MARK: - UITextFieldController

#warning("move into TinyKit")
public final class UITextFieldController: UIViewController, UserInputable, ValueRenderable {
    
    public final var textField: UITextField? {
        
        willSet {
            
            guard isViewLoaded else { return }
            
            removeTextFieldTarget()
            
            textField?.removeFromSuperview()
            
        }
        
        didSet {
            
            guard
                isViewLoaded,
                let textField = textField
            else { return }
            
            view.wrapSubview(textField)
            
            addTextFieldTarget()
            
        }
        
    }
    
    public final var didReceiveUserInput: ( (String?) -> Void )?
    
    public final func render(with text: String?) { textField?.text = text }
    
    public init(_ textField: UITextField? = nil) {
        
        self.textField = textField
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let textField = textField { view.wrapSubview(textField) }
        
        addTextFieldTarget()
        
    }
    
    fileprivate final func addTextFieldTarget() {
        
        textField?.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
    }
    
    fileprivate final func removeTextFieldTarget() {
        
        textField?.removeTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
    }
    
    @objc
    public final func textDidChange(_ textField: UITextField) { didReceiveUserInput?(textField.text) }
    
}
