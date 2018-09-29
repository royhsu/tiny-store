//
//  CheckoutOrderPreviewViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/29.
//

// MARK: - CheckoutOrderPreviewViewController

open class CheckoutOrderPreviewViewController: ViewController {
    
    private final let base = CollectionViewController()
    
    public var _sections: SectionCollection {
        
        get { return base.sections }
        
        set { base.sections = newValue }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
        base.layout = TableViewLayout()
        
    }
    
}
