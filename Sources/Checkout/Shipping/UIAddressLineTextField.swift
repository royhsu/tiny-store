//
//  UIAddressLineTextField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - UIAddressLineTextField

public final class UIAddressLineTextField: View, UserInputable, ValueRenderable {
    
    private final var _line: String? {
        
        didSet { textFieldContainerView.render(with: _line) }
        
    }
    
    public final var line: String? {
        
        get { return _line }
        
        set {
            
            _line = newValue
            
            if let line = line { didReceiveUserInput?(line) }
            
        }
        
    }
    
    public final var placeholder: String? {
        
        get { return textFieldContainerView.textField?.placeholder }
        
        set { textFieldContainerView.textField?.placeholder = newValue }
        
    }
    
    private final lazy var textFieldContainerView: UITextFieldContainerView = {
        
        let textField = UITextField()
        
        textField.textAlignment = .center
        
        return UITextFieldContainerView(textField)
        
    }()
    
    public final var didReceiveUserInput: ( (_ line: String) -> Void )?
    
    public init(line: String? = nil) {
        
        self._line = line
        
        super.init(frame: .zero)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        wrapSubview(textFieldContainerView)
        
        textFieldContainerView.render(with: line)
        
        textFieldContainerView.didReceiveUserInput = { [weak self] line in self?.line = line }
        
    }
    
    public final func render(with line: String?) { _line = line }
    
}
