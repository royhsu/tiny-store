//
//  CheckoutCartViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutCartViewController

public final class CheckoutCartViewController: ViewController {

    private final lazy var collectionViewController: LegacyCollectionViewController = {

        let controller = LegacyCollectionViewController()

        controller.collectionView.applyLayout(LegacyListViewLayout.self)

        controller.collectionView.sections = cart

        return controller

    }()

    public final let cart: CheckoutCart

    public init(cart: CheckoutCart? = nil) {

        self.cart = cart ?? CheckoutCart()

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) {

        self.cart = CheckoutCart()

        super.init(coder: aDecoder)

    }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        addChild(collectionViewController)

        view.wrapSubview(collectionViewController.view)

        collectionViewController.didMove(toParent: self)

    }

}
