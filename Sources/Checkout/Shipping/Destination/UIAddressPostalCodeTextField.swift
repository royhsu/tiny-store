//
//  UIAddressPostalCodeTextField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/29.
//

// MARK: - UIAddressPostalCodeTextField

public final class UIAddressPostalCodeTextField: UIView, UITextFieldDelegate, Bindable, ObservableProtocol {
    
    private final lazy var textField: UITextField = {
        
        let textField = UITextField()
        
        textField.placeholder = NSLocalizedString(
            "Postal Code",
            comment: ""
        )
        
        return textField
        
    }()
    
    public final var dataSource: ( () -> String? )?
    
    public final func reloadData() {
        
        let newText = dataSource?()
        
        text.value = newText
        
        DispatchQueue.main.async { [weak self] in
            
            self?.removeObserverFromTextField()
            
            self?.textField.text = newText
            
            self?.addObserverToTextField()
            
        }
        
    }
    
    private final let text = Observable<String>()
    
    fileprivate final var textObservation: Observation?
    
    public final var value: String? {
        
        get { return text.value }
        
        set { text.value = newValue }
        
    }
    
    public final func observe(
        _ observer: @escaping (ObservedChange<String>) -> Void
    )
    -> Observation { return text.observe(observer) }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    fileprivate final func load() {
        
        wrapSubview(textField)
        
        observeText()
        
        addObserverToTextField()
        
        reloadData()
        
    }
    
    fileprivate final func observeText() {
        
        textObservation = text.observe { [weak self] change in
            
            DispatchQueue.main.async { self?.textField.text = change.currentValue }
            
        }
        
    }
    
    fileprivate final func addObserverToTextField() {
        
        textField.addTarget(
            self,
            action: #selector(updateText),
            for: .editingChanged
        )
        
    }
    
    fileprivate final func removeObserverFromTextField() {
        
        textField.removeTarget(
            self,
            action: #selector(updateText),
            for: .editingChanged
        )
        
    }
    
    @objc
    public final func updateText(_ sender: Any) { text.value = textField.text }
    
}
