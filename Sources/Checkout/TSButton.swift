//
//  TSButton.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSButton

@IBDesignable
open class TSButton: UIView {
    
    private final let button: UIButton = {
        
        let button = UIButton()
        
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        
        button.setTitleColor(
            .black,
            for: .normal
        )
        
        return button
        
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
        
        layer.cornerRadius = 3.0
        
        backgroundColor = UIColor(
            white: 0.85,
            alpha: 1.0
        )
        
        wrapSubview(button)
        
    }
    
}

public extension TSButton {
    
    public final func setTitle(
        _ title: String?,
        for state: UIControl.State
    ) {
        
        button.setTitle(
            title,
            for: state
        )
        
    }
    
}
