//
//  InteractableView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - InteractableView

public final class InteractableView<BindableView: View>: View
where BindableView: UserInputable & ValueRenderable {
    
    private final var isLoaded = false
    
    private final var modelObservation: Observation?
    
    public final var model: Model<BindableView.Value> {
        
        willSet {
            
            guard isLoaded else { return }
            
            modelObservation = nil
            
        }
        
        didSet {
            
            guard isLoaded else { return }
            
            observeModel()
            
            bindableView?.render(with: model.value)
            
        }
        
    }
    
    public final var bindableView: BindableView? {
        
        willSet {
            
            guard isLoaded else { return }
            
            bindableView?.didReceiveUserInput = nil
            
        }
        
        didSet {
            
            guard
                isLoaded,
                let bindableView = bindableView
            else { return }
            
            bindableView.render(with: model.value)
            
            handleUserInput()
            
        }
        
    }

    public init(
        model: Model<BindableView.Value>? = nil,
        bindableView: BindableView? = nil
    ) {
        
        self.model = model ?? Model()
        
        self.bindableView = bindableView
        
        super.init(frame: .zero)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.model = Model()
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() {
        
        isLoaded.toggle()
        
        if let bindableView = bindableView { wrapSubview(bindableView) }
        
        bindableView?.render(with: model.value)
        
        observeModel()
        
        handleUserInput()
        
    }
    
    private final func observeModel() {
        
        modelObservation = model.observe { [weak self] change in
            
            DispatchQueue.main.async {
                
                self?.bindableView?.render(with: change.currentValue)
                
            }
        
        }
        
    }
    
    private final func handleUserInput() {
        
        bindableView?.didReceiveUserInput = { [weak self] value in
            
            self?.model.value = value
            
        }
        
    }
    
}
