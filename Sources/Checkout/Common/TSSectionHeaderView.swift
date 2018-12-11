//
//  TSSectionHeaderView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSSectionHeaderView

@IBDesignable
public final class TSSectionHeaderView: UIView {
    
    private final let label: UILabel = {
        
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        label.adjustsFontForContentSizeCategory = true
        
        return label
        
    }()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        wrapSubview(label) { constraints in
            
            constraints.leadingConstraint.constant = -4.0
            
            constraints.topConstraint.constant = -8.0
            
            constraints.trailingConstraint.constant = 4.0
            
            constraints.bottomConstraint.constant = 8.0
            
        }
        
    }
    
}

public extension TSSectionHeaderView {
    
    @IBInspectable
    public final var title: String? {
        
        get { return label.text }
        
        set { label.text = newValue }
        
    }
    
}
