//
//  UICheckoutDashboardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutDashboardViewController

public final class UICheckoutDashboardViewController: UIViewController {
    
    private final let base = CollectionViewController()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        base.collectionView.alwaysBounceVertical = false
        
        base.collectionView.applyLayout(ListViewLayout.self)
        
        base.collectionView.sections = [
            UICheckoutDashboardTemplate()
        ]
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
