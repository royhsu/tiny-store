//
//  RenderableView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MARK: - RenderableView

public final class RenderableView<BindableView: View>: View where BindableView: ValueRenderable {
    
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
        
        didSet {
            
            guard
                isLoaded,
                let bindableView = bindableView
            else { return }
            
            bindableView.render(with: model.value)
            
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
        
    }
    
    private final func observeModel() {
        
        modelObservation = model.observe { [weak self] change in
            
            DispatchQueue.main.async {
                
                self?.bindableView?.render(with: change.currentValue)
                
            }
            
        }
        
    }
    
}
