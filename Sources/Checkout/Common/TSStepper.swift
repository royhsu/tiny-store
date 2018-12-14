//
//  TSStepper.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - TSStepper

public final class TSStepper: UIView {

    #warning("image size is not set properly.")
    @IBOutlet
    private final var decreaseButton: UIButton! {

        didSet {

            decreaseButton.addTarget(
                self,
                action: #selector(descrease),
                for: .touchUpInside
            )

            decreaseButton.tintColor = tintColor

        }

    }

    #warning("image size is not set properly.")
    @IBOutlet
    private final var increaseButton: UIButton! {

        didSet {

            increaseButton.addTarget(
                self,
                action: #selector(increase),
                for: .touchUpInside
            )

            increaseButton.tintColor = tintColor

        }

    }

    @IBOutlet
    private final var valueTextField: UITextField! {

        didSet { valueTextField.text = "\(value)" }

    }

    private final var _minimumValue: Int = 0

    public final var minimumValue: Int {

        get { return _minimumValue }

        set {

            _minimumValue = min(
                newValue,
                maximumValue
            )

        }

    }

    private final var _maximumValue: Int = 10

    public final var maximumValue: Int {

        get { return _maximumValue }

        set {

            _maximumValue = max(
                minimumValue,
                newValue
            )

        }

    }

    public final var value: Int = 1 {

        willSet {

            guard
                (minimumValue...maximumValue).contains(newValue)
            else { fatalError("Please make sure the value is between \(minimumValue) and \(maximumValue)") }

        }

        didSet {

            valueTextField.text = "\(value)"

            decreaseButton.isEnabled = (value != minimumValue)

            increaseButton.isEnabled = (value != maximumValue)

        }

    }

    public final var valueDidChange: ( (TSStepper) -> Void )?

    public final override var tintColor: UIColor! {

        didSet {

            decreaseButton.tintColor = tintColor

            increaseButton.tintColor = tintColor

            layer.borderColor = tintColor.cgColor

        }

    }

    public final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = .clear

        layer.borderColor = tintColor.cgColor

        layer.borderWidth = 0.5

    }

    @objc
    public final func descrease(sender: Any) {

        value -= 1

        valueDidChange?(self)

    }

    @objc
    public final func increase(sender: Any) {

        value += 1

        valueDidChange?(self)

    }

}
