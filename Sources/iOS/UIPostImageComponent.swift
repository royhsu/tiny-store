//
//  UIPostImageComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostImageComponent

import TinyComponent
import UIKit

public final class UIPostImageComponent: Component {

    /// The base component.
    private final let imageComponent: UIItemComponent<UIImageView>

    private final var imageView: UIImageView { return imageComponent.itemView }

    public final var image: UIImage? {

        get { return imageView.image }

        set { imageView.image = newValue }

    }

    /// - Parameters:
    ///   - contentMode: The default mode is .automatic with zero value of estimated size. This will prevent the list rendering with empty content. Please make sure to give a non-zero size for the list to properly render its content.
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.contentMode = contentMode

        self.imageComponent = UIItemComponent(
            itemView: UIImageView()
        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        prepareLayout()

        imageView.contentMode = .scaleAspectFill

        imageView.clipsToBounds = true

    }

    fileprivate final func prepareLayout() {

        let initialSize: CGSize

        switch contentMode {

        case let .fixed(size): initialSize = size

        case let .automatic(estimatedSize): initialSize = estimatedSize

        }

        imageView.frame.size = initialSize

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        let imageSize: CGSize

        switch contentMode {

        case let .fixed(size): imageSize = size

        case let .automatic(estimatedSize):

            let width = estimatedSize.width

            let height: CGFloat

            if let image = image {

                let imageAspectRatio = (image.size.width / image.size.height)

                height = (width / imageAspectRatio)

            }
            else { height = estimatedSize.height }

            imageSize = CGSize(
                width: width,
                height: height
            )

        }

        imageComponent.contentMode = .fixed(size: imageSize)

        imageComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return imageComponent.view }

    public final var preferredContentSize: CGSize { return imageComponent.preferredContentSize }

}
