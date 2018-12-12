//
//  TSTextFieldNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSTextFieldNibView

internal final class TSTextFieldNibView: UIView {

    @IBOutlet
    internal private(set) final weak var textField: UITextField!

    @IBOutlet
    internal private(set) final weak var bottomLineView: UIView!

    internal final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
