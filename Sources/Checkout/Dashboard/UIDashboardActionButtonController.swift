//
//  UIDashboardActionButtonController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/22.
//

// MARK: - UIDashboardActionButtonController

public final class UIDashboardActionButtonController: UIViewController, DashboardActionController {

    private final lazy var wrapperView: UICheckoutDashboardButtonWrapperView = {

        let view = UIView.loadView(
            UICheckoutDashboardButtonWrapperView.self,
            from: Bundle(for: UICheckoutDashboardButtonWrapperView.self)
        )!

        return view

    }()

    public final var action: DashboardAction? {

        didSet {

            guard isViewLoaded else { return }

            renderView()

            observeModelChanges()

            handleViewActions()

        }

    }

    fileprivate final var isTitleUpdating = false

    fileprivate final var observations: [Observation] = []

    public init(_ action: DashboardAction? = nil) {

        self.action = action

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    public final override func loadView() { view = wrapperView }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        renderView()

        observeModelChanges()

        handleViewActions()

    }

    fileprivate final func renderView() {

        guard let action = action else { return }

        wrapperView.button.setTitle(
            action.title.property.value,
            for: .normal
        )

    }

    fileprivate final func observeModelChanges() {

        guard let action = action else { return }

        observations = [
            action.title.property.observe { [weak self] change in

                guard let self = self else { return }

                self.isTitleUpdating = true

                DispatchQueue.main.async {

                    defer { self.isTitleUpdating = false }

                    self.wrapperView.button.setTitle(
                        change.currentValue,
                        for: .normal
                    )

                }

            }
        ]

    }

    fileprivate final func handleViewActions() {

        wrapperView.button.addTarget(
            self,
            action: #selector(touchUpInside),
            for: .touchUpInside
        )

    }

    @objc
    public final func touchUpInside(_ sender: Any) { action?.handler?() }

}
