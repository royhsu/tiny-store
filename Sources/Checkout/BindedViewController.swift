//
//  BindedViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - BindingViewController

public protocol Outputable {
    
    associatedtype Value
    
    var outputValue: Value? { get set }
    
}

public protocol Inputable {
    
    associatedtype Value
    
    var inputValue: ( (Value?) -> Void )? { get set }
    
}

// MARK: - BindedViewController

public final class BindedViewController<Model, BindedView>: ViewController
where
    BindedView: View & Inputable & Outputable,
    BindedView.Value == Model {
    
    fileprivate final var observation: Observation?
    
    fileprivate final var isModelUpdating = false
    
    public final var model: Content<Model>? {
        
        didSet { observeModelChanges() }
        
    }
    
    public final var bindedView: BindedView? {
        
        didSet {
            
            guard
                isViewLoaded,
                let bindedView = bindedView
            else { return }
            
            view.subviews.forEach { $0.removeFromSuperview() }
            
            view.wrapSubview(bindedView)
            
            renderView()
            
            handleViewActions()
            
        }
        
    }
    
    public init(
        model: Model? = nil,
        bindedView: BindedView? = nil
    ) {
        
        if let model = model { self.model = Content(value: model) }
        
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
        
        renderView()
        
        observeModelChanges()
        
        handleViewActions()
        
    }
    
    fileprivate final func renderView() { bindedView?.outputValue = model?.property.value }
    
    fileprivate final func observeModelChanges() {
        
        observation = model?.property.observe { [weak self] change in
            
            guard let self = self else { return }
            
            self.isModelUpdating = true
            
            DispatchQueue.main.async {
                
                self.bindedView?.outputValue = change.currentValue
                
                self.isModelUpdating = false
                
            }
            
        }
        
    }
    
    fileprivate final func handleViewActions() {
        
        bindedView?.inputValue = { [weak self] newValue in
            
            guard
                let self = self,
                let model = self.model
            else { return }
            
            if self.isModelUpdating { return }
            
            model.property.value = newValue
            
        }
        
    }
    
}
