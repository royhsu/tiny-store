//
//  UIAddressCityButton.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/27.
//

// MARK: - UIAddressCityButton

public final class UIAddressCityButton: UIView, Inputable {

    private final lazy var button: UIButton = {

        let button = UIButton()

        button.setTitleColor(
            UIView().tintColor,
            for: .normal
        )

        return button

    }()

    public final let input = Observable<City>()

    fileprivate final var inputObservation: Observation?

    public final var touchUpInsideHandler: ( () -> Void )?

    public override init(frame: CGRect) {

        super.init(frame: frame)

        self.prepare()

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.prepare()

    }

    fileprivate final func prepare() {

        wrapSubview(button)

        observeInputChanges()

        renderView()

        handleViewActions()

    }

    fileprivate final func observeInputChanges() {

        inputObservation = input.observe { [weak self] _ in

            DispatchQueue.main.async { self?.renderView() }

        }

    }

    fileprivate final func renderView() {

        button.setTitle(
            input.value?.name,
            for: .normal
        )

    }

    fileprivate final func handleViewActions() {

        button.addTarget(
            self,
            action: #selector(touchUpInside),
            for: .touchUpInside
        )

    }

    @objc
    public final func touchUpInside(_ sender: Any) { touchUpInsideHandler?() }

}
