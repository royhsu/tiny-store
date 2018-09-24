//
//  CheckoutSectionHeaderView.swift
//  Patissier
//
//  Created by Roy Hsu on 12/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - CheckoutSectionHeaderView

import UIKit

public final class CheckoutSectionHeaderView: UIView {

    @IBOutlet
    private final weak var topLeftSeparatorLineView: UIView!

    @IBOutlet
    private final weak var bottomLeftSeparatorLineView: UIView!

    @IBOutlet
    private final weak var topRightSeparatorLineView: UIView!

    @IBOutlet
    private final weak var bottomRightSeparatorLineView: UIView!

    @IBOutlet
    private(set) final weak var titleLabel: UILabel!

    private static let preferredHeight: CGFloat = 44.0

    public final override func awakeFromNib() {
        
        super.awakeFromNib()

        setUpSeparatorLineView(topLeftSeparatorLineView)
        
        setUpSeparatorLineView(bottomLeftSeparatorLineView)
        
        setUpSeparatorLineView(topRightSeparatorLineView)
        
        setUpSeparatorLineView(bottomRightSeparatorLineView)
        
        setUpTitleLabel(titleLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpSeparatorLineView(_ view: UIView) {

        #warning("TODO: should be defined in the design system.")
        let lineColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )
        
        view.backgroundColor = lineColor

    }

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        #warning("TODO: should be defined in the design system.")
        label.font = UIFont(
            name: "Georgia",
            size: 16.0
        )

        label.numberOfLines = 1

        label.text = nil

        label.textAlignment = .left

        #warning("TODO: should be defined in the design system.")
        label.textColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )

    }

}
