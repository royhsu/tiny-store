//
//  RenderableViewBinding.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MARK: - RenderableViewBinding

public final class RenderableViewBinding<BindableView: View> where BindableView: ValueRenderable {
    
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
            
            view?.render(with: model.value)
            
        }
        
    }
    
    public final var view: BindableView? {
        
        didSet {
            
            guard
                isLoaded,
                let bindableView = view
            else { return }
            
            bindableView.render(with: model.value)
            
        }
        
    }
    
    public init(
        model: Model<BindableView.Value>? = nil,
        view: BindableView? = nil
    ) {
        
        self.model = model ?? Model()
        
        self.view = view
        
        self.load()
        
    }
    
    private final func load() {
        
        isLoaded.toggle()
        
        view?.render(with: model.value)
        
        observeModel()
        
    }
    
    private final func observeModel() {
        
        modelObservation = model.observe { [weak self] change in
            
            DispatchQueue.main.async {
                
                self?.view?.render(with: change.currentValue)
                
            }
            
        }
        
    }
    
}
