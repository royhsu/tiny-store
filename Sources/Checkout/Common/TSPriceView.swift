//
//  TSPriceView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MAKR: - TSPriceView

@IBDesignable
public final class TSPriceView: UIView {

    private final lazy var numberLabel: UILabel = {

        let label = UILabel()

        label.adjustsFontForContentSizeCategory = true

        label.font = .preferredFont(forTextStyle: .body)

        label.adjustsFontSizeToFitWidth = true

        label.textAlignment = .right

        label.textColor = .black

        return label

    }()
    
    public final var font: UIFont {
        
        get { return numberLabel.font }
        
        set { numberLabel.font = newValue }
        
    }

    @IBInspectable
    public final var price: Double = 0.0 {

        didSet {
            
            guard isLoaded else { return }
            
            numberLabel.text = currencyFormatter.string(from: price)
            
        }

    }

    public final var currencyFormatter: CurrencyFormatter = DefaultCurrencyFormatter()
    
    private final var isLoaded = false

    public override init(frame: CGRect) {

        super.init(frame: frame)

        self.load()

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.load()

    }

    private final func load() {
        
        defer { isLoaded = true }
        
        backgroundColor = nil

        wrapSubview(numberLabel)
        
        numberLabel.text = currencyFormatter.string(from: price)

    }

}
