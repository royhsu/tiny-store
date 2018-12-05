//
//  UICheckoutSelectionView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutSelectionView

@IBDesignable
public class UICheckoutSelectionView: UIView, UserInputable {
    
    private final let imageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.layer.borderWidth = 0.5
        
        imageView.isUserInteractionEnabled = true
        
        return imageView
        
    }()
    
    private final var _isSelected = false {
        
        didSet {
            
            #warning("switch images when the isSelected changes.")
            imageView.backgroundColor = _isSelected ? tintColor : nil
            
        }
        
    }
    
    public final var isSelected: Bool {
        
        get { return _isSelected }
        
        set {
            
            _isSelected = newValue
            
            didReceiveUserInput?(newValue)
            
        }
        
    }
    
    public final var didReceiveUserInput: ( (Bool) -> Void )?
    
    public final override var tintColor: UIColor! {
        
        didSet {
            
            imageView.layer.borderColor = tintColor.cgColor
            
        }
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
    
        wrapSubview(imageView) { constraints in
        
            constraints.leadingConstraint.constant = -8.0
            
            constraints.topConstraint.constant = -8.0
            
            constraints.trailingConstraint.constant = 8.0
            
            constraints.bottomConstraint.constant = 8.0
            
        }
        
        imageView.layer.borderColor = tintColor.cgColor
        
        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggle)
            )
        )
        
    }
    
    public final override func layoutSubviews() {
        
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = imageView.bounds.width / 2.0
        
    }
    
    @objc
    public final func toggle(_ sender: Any) { isSelected.toggle() }
    
}

// MARK: - ValueRenderable

extension UICheckoutSelectionView: ValueRenderable {
    
    public final func render(with isSelected: Bool?) {
        
        if let isSelected = isSelected { _isSelected = isSelected }
        
    }
    
}
