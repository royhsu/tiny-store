//
//  UIPostParagraphComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostParagraphComponent

import TinyComponent
import UIKit

public final class UIPostParagraphComponent: Component {

    /// The base component.
    private final let labelComponent: UIItemComponent<UILabel>

    private final var label: UILabel { return labelComponent.itemView }

    public final var text: String? {

        get { return label.text }

        set { label.text = newValue }

    }

    /// - Parameters:
    ///   - contentMode: The default mode is .automatic with zero value of estimated size. This will prevent the list rendering with empty content. Please make sure to give a non-zero size for the list to properly render its content.
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.labelComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UILabel()
        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 0

        label.font = .systemFont(ofSize: 14.0)

        label.textColor = .black

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return labelComponent.contentMode }

        set { labelComponent.contentMode = newValue }

    }

    public final func render() { labelComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return labelComponent.view }

    public final var preferredContentSize: CGSize { return labelComponent.preferredContentSize }

}
