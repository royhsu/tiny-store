//
//  TSPriceView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MAKR: - TSPriceView

@IBDesignable
public final class TSPriceView: UIView {
    
    private final lazy var priceLabel: UILabel = {
        
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        
        label.font = .preferredFont(forTextStyle: .body)
        
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .right
        
        label.textColor = .black
        
        label.text = priceFormatter.string(from: price)
        
        return label
        
    }()
    
    @IBInspectable
    public final var price: Double = 0.0 {
        
        didSet { priceLabel.text = priceFormatter.string(from: price) }
        
    }
    
    public final var priceFormatter: CurrencyFormatter = DefaultCurrencyFormatter()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        backgroundColor = nil
        
        wrapSubview(priceLabel)
        
    }
    
    public final override var intrinsicContentSize: CGSize { return priceLabel.intrinsicContentSize }
    
}
