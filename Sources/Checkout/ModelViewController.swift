//
//  ModelViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - ModelViewController

public protocol Bindable {
    
    associatedtype Value
    
    var dataSource: ( () -> Value? )? { get set }
    
    func reloadData()
    
}

public final class ModelViewController<
    Value,
    BindableView: View
>: UIViewController
where
    BindableView: ObservableProtocol & Bindable,
    BindableView.Value == Value {
    
    public final var model: Model<Value>? {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            observeModel()
            
            bindedView?.reloadData()
            
        }
        
    }
    
    public final var bindedView: BindableView? {
        
        willSet { bindedView?.removeFromSuperview() }
        
        didSet {
            
            guard
                isViewLoaded,
                let bindedView = bindedView
            else { return }
            
            view.wrapSubview(bindedView)
            
            observeView()
            
            bindedView.reloadData()
            
        }
        
    }
    
    fileprivate final var viewObservation: Observation?
    
    fileprivate final var modelObservation: Observation?
    
    public init(
        model: Model<Value>? = nil,
        bindedView: BindableView? = nil
    ) {
        
        self.model = model
        
        self.bindedView = bindedView
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let bindedView = bindedView { view.wrapSubview(bindedView) }
        
        observeModel()
        
        observeView()
        
        bindedView?.reloadData()
        
    }
    
    fileprivate final func observeModel() {
        
        modelObservation = model?.storage.observe { [weak self] _ in
            
            DispatchQueue.main.async { self?.bindedView?.reloadData() }

        }
        
    }
    
    fileprivate final func observeView() {
        
        bindedView?.dataSource = { [weak self] in self?.model?.storage.value }
        
        viewObservation = bindedView?.observe { [weak self] change in
            
            self?.model?.storage.value = change.currentValue
            
        }

    }

}
