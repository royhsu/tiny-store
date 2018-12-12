//
//  UIDashboardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UIDashboardViewController

public final class UIDashboardViewController: UIViewController {

    private final lazy var collectionViewController: CollectionViewController = {

        let controller = CollectionViewController()

        controller.collectionView.applyLayout(ListViewLayout.self)

        controller.collectionView.sections = dashboard

        return controller

    }()

    public final let dashboard: Dashboard

    public init(_ dashboard: Dashboard? = nil) {

        self.dashboard = dashboard ?? Dashboard()

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) {

        self.dashboard = Dashboard()

        super.init(coder: aDecoder)

    }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        addChild(collectionViewController)

        view.wrapSubview(collectionViewController.view)

        collectionViewController.didMove(toParent: self)

    }

}
