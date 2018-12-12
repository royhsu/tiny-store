//
//  Apparel.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - Apparel

public final class Apparel: CartItem {

    public final var isSelected: Model<Bool>

    public final var title: Model<String>

    public final var description = Model<String>()

    private final var colorObservation: Observation?

    public final var color: Model<String> {

        didSet {

            colorObservation = color.observe { [weak self] _ in self?.description.value = self?.itemDescription }

        }

    }

    private final var sizeObservation: Observation?

    public final var size: Model<String> {

        didSet {

            sizeObservation = size.observe { [weak self] _ in self?.description.value = self?.itemDescription }

        }

    }

    public final var price: Model<Double>

    public final var quantity: Model<Int>

    public init(
        isSelected: Bool,
        title: String,
        color: String,
        size: String,
        price: Double,
        quantity: Int
    ) {

        self.isSelected = Model(value: isSelected)

        self.title = Model(value: title)

        self.color = Model(value: color)

        self.size = Model(value: size)

        self.price = Model(value: price)

        self.quantity = Model(value: quantity)

        self.load()

    }

    private final func load() {

        description.value = itemDescription

        colorObservation = color.observe { [weak self] _ in self?.description.value = self?.itemDescription }

        sizeObservation = size.observe { [weak self] _ in self?.description.value = self?.itemDescription }

    }

    private final var itemDescription: String? {

        guard
            let color = self.color.value,
            let size = self.size.value
        else { return nil }

        return "\(color) - \(size)"

    }

}
