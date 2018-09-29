//
//  CheckoutFlow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutFlowController

public final class CheckoutFlowController: ViewController {
    
    public enum Step {
        
        case fillOutOrder(OrderStepViewController)
        
        case previewOrder(CheckoutOrderPreviewViewController)
        
        case finishPayment(ViewController)
        
        var viewController: ViewController {
            
            switch self {
                
            case let .fillOutOrder(controller): return controller
                
            case let .previewOrder(controller): return controller
                
            case let .finishPayment(controller): return controller
                
            }
            
        }
        
    }
    
    /// A flow shouldn't be interrupted after it gets started.
    /// Please make sure to check this value before an operation tries to do so.
    public final var isFlowRunning: Bool { return !queuedSteps.isEmpty }
    
    fileprivate final var queuedSteps: [Step] = []
    
    private final var step: Step? {
        
        didSet {
            
            switch step {
                
            case let .fillOutOrder(viewController)?:
                
                viewController.makeOrder { [weak self] result in
                    
                    guard
                        let self = self
                    else { return }
                    
                    switch result {
                        
                    case let .success(order):
                        
                        print("Process order...\n", order)
                        
                        self.step = self.nextStep()
                        
                    case let .failure(error):
                        
                        #warning("error handling.")
                        
                        print("\(error)")
                        
                    }
                    
                }
                
                base.setViewControllers(
                    [ viewController ],
                    animated: true
                )
                
            case let .previewOrder(viewController)?:
                
                base.pushViewController(
                    viewController,
                    animated: true
                )
                
            case let .finishPayment(viewController)?:
                
                base.pushViewController(
                    viewController,
                    animated: true
                )
                
            case .none:
                
                queuedSteps = []
                
                base.setViewControllers(
                    [ plainViewController ],
                    animated: true
                )
                
            }
            
        }
        
    }
    
    public typealias OrderStepViewController = CheckoutOrderStep & ViewController
    
    public final var orderViewController: OrderStepViewController? {
        
        didSet { startFlowIfAvailable() }
        
    }
    
    public typealias OrderPreviewStepViewController = CheckoutOrderPreviewViewController
    
    public final var orderPreviewViewController: OrderPreviewStepViewController? {
        
        didSet { startFlowIfAvailable() }
        
    }
    
    fileprivate final let plainViewController: ViewController = {
     
        let viewController = ViewController()
        
        viewController.view.backgroundColor = .white
        
        return viewController
        
    }()
    
    /// The base.
    private final lazy var base: NavigationController = { return NavigationController(rootViewController: plainViewController) }()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)

        view.wrapSubview(base.view)

        base.didMove(toParent: self)
        
        startFlowIfAvailable()
        
    }
    
    fileprivate final func startFlowIfAvailable() {
        
        guard
            isViewLoaded,
            !isFlowRunning,
            var steps = generateSteps(),
            !steps.isEmpty
        else { return }
        
        let firstStep = steps.removeFirst()
        
        queuedSteps = steps
        
        step = firstStep
        
    }
    
    fileprivate final func generateSteps() -> [Step]? {
        
        #warning("log some warning if any dependency is missing.")
        guard
            let orderViewController = orderViewController,
            let orderPreviewStepViewController = orderPreviewViewController
        else { return nil }
        
        return [
            .fillOutOrder(orderViewController),
            .previewOrder(orderPreviewStepViewController)
        ]
        
    }
    
    fileprivate final func nextStep() -> Step {
        
        if queuedSteps.isEmpty { return .finishPayment(plainViewController) }
        
        let nextStep = queuedSteps.removeFirst()
        
        return nextStep
        
    }
    
}
