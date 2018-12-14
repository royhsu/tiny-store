//
//  TSCartItemNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - TSCartItemNibView

public final class TSCartItemNibView: UIView {

    @IBOutlet
    private final weak var selectionView: TSSelectionView! {

        didSet {

            selectionView.tintColor = .black

            selectionView.selectionDidChange = { [weak self] _ in

                guard let self = self else { return }

                self.contentStackView.alpha = self.isSelected ? 1.0 : 0.5

                self.quantityStepper.isUserInteractionEnabled = self.isSelected

                self.selectionDidChange?(self)

            }

        }

    }

    public final var isSelected: Bool {

        get { return selectionView.isSelected }

        set {

            selectionView.isSelected = newValue

            contentStackView.alpha = isSelected ? 1.0 : 0.5

            quantityStepper.isUserInteractionEnabled = isSelected

        }

    }

    public final var selectionDidChange: ( (TSCartItemNibView) -> Void )? {

        didSet {

            selectionView.selectionDidChange = { [weak self] _ in

                guard let self = self else { return }

                self.contentStackView.alpha = self.isSelected ? 1.0 : 0.5

                self.quantityStepper.isUserInteractionEnabled = self.isSelected

                self.selectionDidChange?(self)

            }

        }

    }

    @IBOutlet
    private final weak var contentStackView: UIStackView!

    @IBOutlet
    public private(set) final weak var previewImageView: UIImageView! {

        didSet {
            previewImageView.layer.borderColor = UIColor.darkGray.cgColor

            previewImageView.layer.borderWidth = 0.5

        }

    }

    @IBOutlet
    public private(set) final weak var titleLabel: UILabel! {

        didSet { titleLabel.text = nil }

    }

    @IBOutlet
    public private(set) final weak var descriptionLabel: UILabel! {

        didSet { descriptionLabel.text = nil }

    }

    @IBOutlet
    public private(set) final weak var priceView: TSPriceView!

    @IBOutlet
    private final weak var quantityStepperContainerView: UIView! {

        didSet { quantityStepperContainerView.backgroundColor = nil }

    }

    public final let quantityStepper: TSStepper = {

        let stepper = UIView.loadView(
            TSStepper.self,
            from: Bundle(for: TSStepper.self)
        )!

        stepper.tintColor = .black

        return stepper

    }()

    public final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = .clear

        quantityStepperContainerView.wrapSubview(quantityStepper)

        contentStackView.alpha = isSelected ? 1.0 : 0.5

        quantityStepper.isUserInteractionEnabled = isSelected

    }

}
