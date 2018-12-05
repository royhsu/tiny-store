//
//  InputableViewBinding.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - InputableViewBinding

public final class InputableViewBinding<BindableView: View>
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
            
            view.render(with: model.value)
            
        }
        
    }
    
    public final var view: BindableView {
        
        willSet {
            
            guard isLoaded else { return }
            
            view.didReceiveUserInput = nil
            
        }
        
        didSet {
            
            guard isLoaded else { return }
            
            view.render(with: model.value)
            
            handleUserInput()
            
        }
        
    }

    public init(
        model: Model<BindableView.Value>,
        view: BindableView
    ) {
        
        self.model = model
        
        self.view = view
        
        self.load()
        
    }
    
    private final func load() {
        
        isLoaded.toggle()
        
        view.render(with: model.value)
        
        observeModel()
        
        handleUserInput()
        
    }
    
    private final func observeModel() {
        
        modelObservation = model.observe { [weak self] change in
            
            DispatchQueue.main.async {
                
                self?.view.render(with: change.currentValue)
                
            }
        
        }
        
    }
    
    private final func handleUserInput() {
        
        view.didReceiveUserInput = { [weak self] value in
            
            self?.model.value = value
            
        }
        
    }
    
}
