//
//  TSCheckoutNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - TSCheckoutNibView

internal final class TSCheckoutNibView: UIView {

    @IBOutlet
    internal final weak var backgroundContainerView: UIView! {

        didSet { backgroundContainerView.backgroundColor = nil }

    }

    @IBOutlet
    internal final weak var dashboardContainerView: UIView! {

        didSet { dashboardContainerView.backgroundColor = nil }

    }

    internal final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
