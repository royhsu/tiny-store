//
//  UICheckoutItemTemplate.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: CheckoutItemTemplate {

    public struct Configuration: TemplateConfiguration {

        public typealias Element = UICheckoutItemTemplateElement

    }

    private let template: ConfigurableTemplate<CheckoutItemField, Configuration>

    public init(
        field: CheckoutItemField,
        elements: [Configuration.Element] = [ .stepper ]
    ) {

        self.template = ConfigurableTemplate(
            storage: field,
            elements: elements
        )

        self.prepare()

    }

    public init(_ field: CheckoutItemField) { self.init(field: field) }

    fileprivate func prepare() {

        template.registerView(
            UICheckoutItemView.self,
            from: Bundle(for: UICheckoutItemView.self),
            binding: { field, view in view.itemField = field },
            for: .stepper
        )

    }

    public var numberOfViews: Int { return template.numberOfViews }

    public func view(at index: Int) -> View { return template.view(at: index) }

}
