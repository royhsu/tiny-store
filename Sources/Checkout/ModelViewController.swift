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
    
    fileprivate final var inputObservation: NSKeyValueObservation?
    
    fileprivate final var modelObservation: NSKeyValueObservation?
    
    fileprivate final var isModelUpdating = false
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        observeModelChanges()
        
        renderView()
        
        handleViewActions()
        
    }
    
    fileprivate final func observeModelChanges() {
        
        modelObservation = model?.storage.observe(
            \.value,
            options: [ .initial, .new ]
        ) { [weak self] model, _ in
            
            guard let self = self else { return }
            
            self.isModelUpdating = true
            
            self.bindedView?.input.value = model.value
            
            self.isModelUpdating = false
            
        }
        
    }
    
    fileprivate final func renderView() { bindedView?.input.value = model?.storage.value }
    
    fileprivate final func handleViewActions() {
        
        inputObservation = bindedView?.input.observe(
            \.value,
            options: [ .initial, .new ]
        ) { [weak self] input, _ in self?.model?.storage.value = input.value }
        
    }
    
}
