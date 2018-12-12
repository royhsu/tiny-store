//
//  TSShippingServiceNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - TSShippingServiceNibView

public final class TSShippingServiceNibView: UIView {

    @IBOutlet
    private final weak var selectionView: TSSelectionView! {

        didSet {
            
            selectionView.tintColor = .black
            
            selectionView.selectionDidChange = { [weak self] _ in
                
                guard let self = self else { return }
                
                self.selectionDidChange?(self)
                
            }
            
        }

    }

    public final var isSelected: Bool {

        get { return selectionView.isSelected }

        set { selectionView.isSelected = newValue }

    }

    public final var selectionDidChange: ( (TSShippingServiceNibView) -> Void )? {

        didSet {

            selectionView.selectionDidChange = { [weak self] _ in

                guard let self = self else { return }

                self.selectionDidChange?(self)

            }

        }

    }

    @IBOutlet
    public private(set) final weak var titleLabel: UILabel! {

        didSet {

            titleLabel.adjustsFontForContentSizeCategory = true

            titleLabel.font = .preferredFont(forTextStyle: .body)

            titleLabel.numberOfLines = 0

            titleLabel.text = nil

        }

    }

    @IBOutlet
    public private(set) weak var priceView: TSPriceView!

    public final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil
        
        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggleSelection)
            )
        )

    }

    @objc
    public final func toggleSelection(_ gesuture: UITapGestureRecognizer) { selectionView.toggleSelection(gesuture) }

}
