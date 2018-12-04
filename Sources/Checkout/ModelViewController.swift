//
//  ModelViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - ModelViewController

public final class ModelViewController<BindableViewController: ViewController>: ViewController
where BindableViewController: UserInputable & ValueRenderable {
    
    fileprivate final var modelObservation: Observation?
    
    public final let model = Model<BindableViewController.Value>()
    
    public final var bindableViewController: BindableViewController? {
        
        willSet {
            
            guard isViewLoaded else { return }
            
            bindableViewController?.didReceiveUserInput = nil
            
            bindableViewController?.willMove(toParent: nil)
            
            bindableViewController?.view.removeFromSuperview()
            
            bindableViewController?.removeFromParent()
            
        }
        
        didSet {
            
            guard
                isViewLoaded,
                let bindableViewController = bindableViewController
            else { return }
            
            addChild(bindableViewController)
            
            view.wrapSubview(bindableViewController.view)
            
            bindableViewController.didMove(toParent: self)
            
            handleUserInput()
            
        }
        
    }

    public init(bindableViewController: BindableViewController? = nil) {
        
        self.bindableViewController = bindableViewController
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let bindableViewController = bindableViewController {
            
            addChild(bindableViewController)
            
            view.wrapSubview(bindableViewController.view)
            
            bindableViewController.didMove(toParent: self)
            
        }
        
        observeModel()
        
        handleUserInput()
        
    }
    
    fileprivate final func observeModel() {
        
        modelObservation = model.storage.observe { [weak self] change in
            
            DispatchQueue.main.async {
                
                self?.bindableViewController?.render(with: change.currentValue)
                
            }
        
        }
        
    }
    
    fileprivate final func handleUserInput() {
        
        bindableViewController?.didReceiveUserInput = { [weak self] value in
            
            self?.model.storage.value = value
            
        }
        
    }
    
}
