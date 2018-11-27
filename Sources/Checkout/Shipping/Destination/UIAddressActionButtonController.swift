//
//  UIAddressActionButtonController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/27.
//

// MARK: - UIAddressActionButtonController

@objcMembers
public final class AddressAction: NSObject {
    
    public dynamic var title: String?
    
    public init(title: String) { self.title = title }
    
}

public final class UIAddressActionButtonController: UIViewController {
    
    private final lazy var button: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(
            UIView().tintColor,
            for: .normal
        )
        
        return button
        
    }()
    
    public final var action: AddressAction? {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            renderView()
            
            observeModelChanges()
            
            handleViewActions()
            
        }
        
    }
    
    fileprivate final var isTitleUpdating = false
    
    fileprivate final var observations: [NSKeyValueObservation] = []
    
    public final var actionHandler: ( () -> Void )?
    
    public final override func loadView() { view = button }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        renderView()
        
        observeModelChanges()
        
        handleViewActions()
        
    }
    
    fileprivate final func renderView() {
        
        button.setTitle(
            action?.title,
            for: .normal
        )
        
    }
    
    fileprivate final func observeModelChanges() {
        
        guard let action = action else { return }
        
        observations = [
            action.observe(
                \.title,
                options: [ .initial, .new ],
                changeHandler: { [weak self] action, _ in
                
                    guard let self = self else { return }

                    self.isTitleUpdating = true

                    DispatchQueue.main.async {

                        defer { self.isTitleUpdating = false }

                        self.button.setTitle(
                            action.title,
                            for: .normal
                        )

                    }
                        
                }
            )
        ]
        
    }
    
    fileprivate final func handleViewActions() {
        
        button.addTarget(
            self,
            action: #selector(touchUpInside),
            for: .touchUpInside
        )
        
    }
    
    @objc
    public final func touchUpInside(_ sender: Any) { actionHandler?() }
    
}
