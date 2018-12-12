//
//  UINibWrapperView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - UINibWrapperView

#warning("move to TinyKit.")
#warning("cannot connect to an IBOutlet with erorr message: @IBOutlet property cannot have non-'@objc' class type.")

@IBDesignable
open class UINibWrapperView<WrappedView>: UIView where WrappedView: UIView {

    public final let wrappedView: WrappedView = {

        return UIView.loadView(
            WrappedView.self,
            from: Bundle(for: WrappedView.self)
        )!

    }()

    public override init(frame: CGRect) {

        super.init(frame: frame)

        self.prepare()

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.prepare()

    }

    fileprivate final func prepare() { wrapSubview(wrappedView) }

}
