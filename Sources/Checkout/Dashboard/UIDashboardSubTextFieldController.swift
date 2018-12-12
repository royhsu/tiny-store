//
//  UIDashboardSubRowViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/22.
//

// MARK: - UIDashboardSubRowViewController

public final class UIDashboardSubRowViewController: UIViewController, DashboardRowController {

    private final lazy var textField: UIDashboardSubTextField = {

        let field = UIView.loadView(
            UIDashboardSubTextField.self,
            from: Bundle(for: UIDashboardSubTextField.self)
        )!

        return field

    }()

    public final var row: DashboardRow? {

        didSet {

            guard isViewLoaded else { return }

            renderView()

            observeModelChanges()

            handleViewActions()

        }

    }

    fileprivate final var isTitleUpdating = false

    fileprivate final var isAmountUpdating = false

    fileprivate final var observations: [Observation] = []

    #warning("move into text field.")
    public final var currencyFormatter: CurrencyFormatter = DefaultCurrencyFormatter()

    public init(_ row: DashboardRow? = nil) {

        self.row = row

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    public final override func loadView() { view = textField }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        renderView()

        observeModelChanges()

        handleViewActions()

    }

    fileprivate final func renderView() {

        guard let row = row else { return }

        textField.titleLabel.text = row.title.property.value

        let amount = row.amount.property.value ?? 0.0

        textField.amountLabel.text = currencyFormatter.string(from: amount)

    }

    fileprivate final func observeModelChanges() {

        guard let row = row else { return }

        observations = [
            row.title.property.observe { [weak self] change in

                guard let self = self else { return }

                self.isTitleUpdating = true

                DispatchQueue.main.async {

                    defer { self.isTitleUpdating = false }

                    self.textField.titleLabel.text = change.currentValue

                }

            },
            row.amount.property.observe { [weak self] _ in

                guard let self = self else { return }

                self.isAmountUpdating = true

                DispatchQueue.main.async {

                    defer { self.isAmountUpdating = false }

                    let amount = row.amount.property.value ?? 0.0

                    self.textField.amountLabel.text = self.currencyFormatter.string(from: amount)

                }

            }
        ]

    }

    fileprivate final func handleViewActions() { }

}
