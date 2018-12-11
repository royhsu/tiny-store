//
//  TSSelectionView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - TSSelectionView

@IBDesignable
public class TSSelectionView: UIView {
    
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
    
    public final var selectionDidChange: ( (TSSelectionView) -> Void )?
    
    public final override var tintColor: UIColor! {
        
        didSet { imageView.layer.borderColor = tintColor.cgColor }
        
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
                action: #selector(toggleSelection)
            )
        )
        
    }
    
    public final override func layoutSubviews() {
        
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = imageView.bounds.width / 2.0
        
    }
    
    @objc
    public final func toggleSelection(_ gesture: UITapGestureRecognizer) {
        
        isSelected.toggle()
        
        selectionDidChange?(self)
        
    }
    
}
