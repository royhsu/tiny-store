//
//  TSDashboardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/14.
//

// MARK: - TSDashboardViewController

#if canImport(UIKit)

public final class TSDashboardViewController: UIViewController {
    
    private final lazy var dashboardView: TSDashboardNibView = {
        
        let view = UIView.loadView(
            TSDashboardNibView.self,
            from: Bundle(for: TSDashboardNibView.self)
        )!
        
        return view
        
    }()
 
    public final override func loadView() { view = dashboardView }
    
}

#endif
