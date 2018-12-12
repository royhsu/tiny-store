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
                to: itemView,
                for: \.isSelected
            )

            item?.title.bind(
                to: itemView.titleLabel,
                for: \.text
            )

            item?.description.bind(
                to: itemView.descriptionLabel,
                for: \.text
            )

            item?.price.bind(
                to: itemView.priceView,
                for: \.price
            )

            item?.quantity.bind(
                to: itemView.quantityStepper,
                for: \.value
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
            to: itemView,
            for: \.isSelected
        )

        item?.title.bind(
            to: itemView.titleLabel,
            for: \.text
        )

        item?.description.bind(
            to: itemView.descriptionLabel,
            for: \.text
        )

        item?.price.bind(
            to: itemView.priceView,
            for: \.price
        )

        item?.quantity.bind(
            to: itemView.quantityStepper,
            for: \.value
        )

    }

}
