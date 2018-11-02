//
//  UICheckoutSelectionView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutSelectionView

@IBDesignable
public class UICheckoutSelectionView: UIView {
    
    private final let imageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.layer.borderWidth = 0.5
        
        imageView.isUserInteractionEnabled = true
        
        return imageView
        
    }()
    
    public final var isSelected = false {
        
        didSet {
            
            #warning("switch images when the isSelected changes.")
            imageView.backgroundColor = isSelected ? tintColor : nil
            
        }
        
    }
    
    public final override var tintColor: UIColor! {
        
        didSet {
            
            imageView.layer.borderColor = tintColor.cgColor
            
        }
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
    
        let constraints = wrapSubview(imageView)
        
        constraints.leadingConstraint.constant = -6.0
        
        constraints.topConstraint.constant = -6.0
        
        constraints.trailingConstraint.constant = 6.0
        
        constraints.bottomConstraint.constant = 6.0
        
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
