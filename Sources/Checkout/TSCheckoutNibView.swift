//
//  TSCheckoutNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - TSCheckoutNibView

internal final class TSCheckoutNibView: UIView {

    @IBOutlet
    internal private(set) final weak var backgroundContainerView: UIView!

    @IBOutlet
    internal private(set) final weak var dashboardView: TSDashboardView!
    
    internal final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
