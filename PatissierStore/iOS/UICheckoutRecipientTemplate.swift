//
//  UICheckoutRecipientTemplate.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/25.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutRecipientTemplate

public struct UICheckoutRecipientTemplate: CheckoutRecipientTemplate {

    public struct Configuration: TemplateConfiguration {

        public typealias Element = UICheckoutRecipientTemplateElement

    }

    private let template: ConfigurableTemplate<CheckoutRecipientField, Configuration>

    public init(
        field: CheckoutRecipientField,
        elements: [Configuration.Element] = [
            .header,
            .form
        ]
    ) {

        self.template = ConfigurableTemplate(
            storage: field,
            elements: elements
        )

        self.prepare()

    }

    public init(_ field: CheckoutRecipientField) { self.init(field: field) }

    fileprivate func prepare() {

        template.registerView(
            UICheckoutSectionHeaderView.self,
            from: Bundle(for: UICheckoutSectionHeaderView.self),
            binding: { _, view in

                #warning("TODO: should be defined in the locale system.")
                view.titleLabel.text = NSLocalizedString(
                    "Recipient",
                    comment: ""
                )

            },
            for: .header
        )

        template.registerView(
            UICheckoutRecipientView.self,
            from: Bundle(for: UICheckoutRecipientView.self),
            binding: { field, view in view.recipientField = field },
            for: .form
        )

    }

    public var numberOfViews: Int { return template.numberOfViews }

    public func view(at index: Int) -> View { return template.view(at: index) }

}
