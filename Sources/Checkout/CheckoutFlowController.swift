//
//  CheckoutFlow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutFlowController

public final class CheckoutFlowController: ViewController {
    
    public enum Step {
        
        case orderFilling(OrderFillingStep)
        
        case orderPreviewing(OrderPreviewingStep)
        
        case paymentFinished(ViewController)
        
    }
    
    /// A flow shouldn't be interrupted after it gets started.
    /// Please make sure to check this value before an operation tries to do so.
    public final var isRunning: Bool { return !stepQueue.isEmpty }
    
    fileprivate final var stepQueue: [Step] = []
    
    private final var step: Step? {
        
        didSet {
            
            switch step {
                
            case let .orderFilling(step)?:
                
                step.fillOutOrder { [weak self] result in
                    
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
                    [ step ],
                    animated: true
                )
                
            case let .orderPreviewing(step)?:
                
                #warning("add an abstract layer that encapsulate pushViewController(:animated:) into base.next(step).")
                base.pushViewController(
                    step,
                    animated: true
                )
                
            case let .paymentFinished(step)?:
                
                base.pushViewController(
                    step,
                    animated: true
                )
                
            case .none:
                
                stepQueue = []
                
                base.setViewControllers(
                    [ plainViewController ],
                    animated: true
                )
                
            }
            
        }
        
    }
    
    public typealias OrderFillingStep = CheckoutOrderFillingStep & ViewController
    
    public final var orderFillingStep: OrderFillingStep? {
        
        didSet { startFlowIfAvailable() }
        
    }
    
    public typealias OrderPreviewingStep = CheckoutOrderPreviewingStep & ViewController
    
    public final var orderPreviewingStep: OrderPreviewingStep? {
        
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
            !isRunning,
            var steps = generateSteps(),
            !steps.isEmpty
        else { return }
        
        let firstStep = steps.removeFirst()
        
        stepQueue = steps
        
        step = firstStep
        
    }
    
    fileprivate final func generateSteps() -> [Step]? {
        
        #warning("log some warning if any dependency is missing.")
        guard
            let orderViewController = orderFillingStep,
            let orderPreviewStepViewController = orderPreviewingStep
        else { return nil }
        
        return [
            .orderFilling(orderViewController),
            .orderPreviewing(orderPreviewStepViewController)
        ]
        
    }
    
    fileprivate final func nextStep() -> Step {
        
        if stepQueue.isEmpty { return .paymentFinished(plainViewController) }
        
        let nextStep = stepQueue.removeFirst()
        
        return nextStep
        
    }
    
}
