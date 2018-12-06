//
//  UIAdressStateButton.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/27.
//

// MARK: - UIAdressStateButton

public final class UIAdressStateButton: UIView, ValueRenderable {
    
    public final var city: State? {
        
        didSet {
            
            button.setTitle(
                city?.name,
                for: .normal
            )
            
        }
        
    }
    
    private final lazy var button: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(
            UIView().tintColor,
            for: .normal
        )
        
        return button
        
    }()
    
    public final var cityPickerPresenter: ( (UIAdressStateButton) -> Void )?
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        wrapSubview(button)
        
        button.setTitle(
            city?.name,
            for: .normal
        )
        
        button.addTarget(
            self,
            action: #selector(touchUpInside),
            for: .touchUpInside
        )
        
    }
    
    @objc
    public final func touchUpInside(_ sender: Any) { cityPickerPresenter?(self) }
    
    public final func render(with city: State?) { self.city = city }
    
}
