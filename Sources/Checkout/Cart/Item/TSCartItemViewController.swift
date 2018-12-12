//
//  TSCartItemViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - TSCartItemViewController

public final class TSCartItemViewController: UIViewController, CartItemController {

    private final lazy var itemView: TSCartItemNibView = {

        let view = UIView.loadView(
            TSCartItemNibView.self,
            from: Bundle(for: TSCartItemNibView.self)
        )!

        view.selectionDidChange = { [weak self] view in self?.item?.isSelected.value = view.isSelected }

        view.quantityStepper.minimumValue = 1

        view.quantityStepper.maximumValue = 99

        view.quantityStepper.valueDidChange = { [weak self] stepper in self?.item?.quantity.value = stepper.value }

        return view

    }()

    private final var isItemBound = false

    public final var item: CartItem? {

        didSet {

            guard isViewLoaded && isItemBound else { return }

            item?.isSelected.bind(
                transform: { $0 ?? false },
                to: itemView,
                keyPath: \.isSelected
            )

            item?.title.bind(
                to: itemView.titleLabel,
                keyPath: \.text
            )

            item?.description.bind(
                to: itemView.descriptionLabel,
                keyPath: \.text
            )

            item?.price.bind(
                transform: { $0 ?? 0.0 },
                to: itemView.priceView,
                keyPath: \.price
            )

            item?.quantity.bind(
                transform: { $0 ?? 1 },
                to: itemView.quantityStepper,
                keyPath: \.value
            )

        }

    }

    public init(_ item: CartItem? = nil) {

        self.item = item

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    public final override func loadView() { view = itemView }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        defer { isItemBound = true }

        item?.isSelected.bind(
            transform: { $0 ?? false },
            to: itemView,
            keyPath: \.isSelected
        )
        
        item?.title.bind(
            to: itemView.titleLabel,
            keyPath: \.text
        )
        
        item?.description.bind(
            to: itemView.descriptionLabel,
            keyPath: \.text
        )
        
        item?.price.bind(
            transform: { $0 ?? 0.0 },
            to: itemView.priceView,
            keyPath: \.price
        )
        
        item?.quantity.bind(
            transform: { $0 ?? 1 },
            to: itemView.quantityStepper,
            keyPath: \.value
        )

    }

}
