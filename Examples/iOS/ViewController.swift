//
//  ViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/5/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewController

import TinyComponent
import TinyStore
import UIKit

public final class ViewController: UIViewController {

    private final let listComponent = UIListComponent()
    
    private final let productDetailComponent = UIProductDetailComponent()

    public final override func loadView() { view = listComponent.view }

//    public final override func loadView() { view = productDetailComponent.view }
    
    public final override func viewDidLoad() {

        super.viewDidLoad()

        setUpRootView(view)

    }

    public final override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

//        let image1Component = UIPostImageComponent()
//
//        image1Component.contentMode = .automatic(
//            estimatedSize: CGSize(
//                width: 414.0,
//                height: 50.0
//            )
//        )
//
//        image1Component.image = #imageLiteral(resourceName: "image-product-story-1")
//
//        print(image1Component.preferredContentSize)
//
//        image1Component.render()
//
//        print(image1Component.preferredContentSize)

//        let image2Component = UIPostImageComponent()
//
//        image2Component.image = #imageLiteral(resourceName: "image-product-story-2")
//
//        let image3Component = UIPostImageComponent()
//
//        image3Component.image = #imageLiteral(resourceName: "image-product-story-4")
//
//        let image4Component = UIPostImageComponent()
//
//        image4Component.image = #imageLiteral(resourceName: "image-product-story-3")
//
        let paragraph1Component = UIPostParagraphComponent()

        paragraph1Component.text = "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas sed diam eget risus varius blandit sit amet non magna. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."

        let paragraph2Component = UIPostParagraphComponent()

        paragraph2Component.text = "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus."

        let paragraph3Component = UIPostParagraphComponent()

        paragraph3Component.text = "Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec sed odio dui. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Lorem ipsum dolor sit amet, consectetur adipiscing elit."

        productDetailComponent.titleLabel.text = "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus."

        productDetailComponent.subtitleLabel.text = "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas sed diam eget risus varius blandit sit amet non magna. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        
        listComponent.headerComponent = productDetailComponent
        
        listComponent.setItemComponents(
            [
//                image1Component,
//                image2Component,
                paragraph1Component,
//                image3Component,
                paragraph2Component,
//                image4Component,
                paragraph3Component
            ]
        )

        listComponent.contentMode = .fixed(size: view.bounds.size)

        listComponent.render()
        
//        productDetailComponent.contentMode = .fixed(size: view.bounds.size)
//
//        productDetailComponent.render()

    }

    // MARK: Set Up

    fileprivate final func setUpRootView(_ view: UIView) { view.backgroundColor = .white }

}
