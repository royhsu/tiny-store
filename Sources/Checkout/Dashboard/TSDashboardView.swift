//
//  TSDashboardView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/14.
//

// MARK: - TSDashboardView

#if canImport(UIKit)

@IBDesignable
public final class TSDashboardView: UIView {
    
    private final lazy var _nibView: TSDashboardNibView = {
        
        let view = UIView.loadView(
            TSDashboardNibView.self,
            from: Bundle(for: TSDashboardNibView.self)
        )!
        
        return view
        
    }()
    
    public final var subTotal: Double {
        
        get { return _nibView.subTotalPriceView.price }
        
        set {
            
            _nibView.subTotalPriceView.price = newValue
            
            _nibView.payTotalPriceView.price = payTotal
            
        }
        
    }
    
    public final var shipping: Double {
        
        get { return _nibView.shippingPriceView.price }
        
        set {
            
            _nibView.shippingPriceView.price = newValue
            
            _nibView.payTotalPriceView.price = payTotal
            
        }
        
    }
    
    public final var payTotal: Double { return subTotal + shipping }
    
    public final var currencyFormatter: CurrencyFormatter = DefaultCurrencyFormatter() {
        
        didSet {
            
            guard isLoaded else { return }
            
            _nibView.subTotalPriceView.currencyFormatter = currencyFormatter
            
            _nibView.shippingPriceView.currencyFormatter = currencyFormatter
            
            _nibView.payTotalPriceView.currencyFormatter = currencyFormatter
            
        }
        
    }
    
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
        
        wrapSubview(_nibView)
        
        _nibView.subTotalPriceView.currencyFormatter = currencyFormatter
        
        _nibView.shippingPriceView.currencyFormatter = currencyFormatter
        
        _nibView.payTotalPriceView.currencyFormatter = currencyFormatter
        
    }
    
}

#endif
