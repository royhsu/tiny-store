//
//  ModelViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - ModelViewController

public final class ModelViewController<
    Value,
    InputableView: View
>: UIViewController
where
    InputableView: Inputable,
    InputableView.Value == Value {
    
    public final var model: Model<Value>? {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            observeModelChanges()
            
        }
        
    }
    
    public final var bindedView: InputableView? {
        
        willSet { bindedView?.removeFromSuperview() }
        
        didSet {
            
            guard
                isViewLoaded,
                let bindedView = bindedView
            else { return }
            
            view.wrapSubview(bindedView)
            
            renderView()
            
            handleViewActions()
            
        }
        
    }
    
    fileprivate final var inputObservation: Observation?
    
    fileprivate final var modelObservation: Observation?
    
    fileprivate final var isModelUpdating = false
    
    public init(
        model: Model<Value>? = nil,
        bindedView: InputableView? = nil
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
        
        observeModelChanges()
        
        renderView()
        
        handleViewActions()
        
    }
    
    fileprivate final func observeModelChanges() {
        
        modelObservation = model?.storage.observe { [weak self] _ in

            guard let self = self else { return }

            self.isModelUpdating = true

            DispatchQueue.main.async {
                
                defer { self.isModelUpdating = false }
                
                self.renderView()
                
            }

        }
        
    }
    
    fileprivate final func renderView() { bindedView?.input.value = model?.storage.value }
    
    #warning("FIXME: The input changes should always delegate to the model. The current implementation will ignore changes while model is updating.")
    fileprivate final func handleViewActions() {
        
        inputObservation = bindedView?.input.observe { [weak self] change in
            
            guard let self = self else { return }
            
            if self.isModelUpdating { return }
            
            self.model?.storage.value = change.currentValue
            
        }

    }
    
}
