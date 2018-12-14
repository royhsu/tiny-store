import PlaygroundSupport
import TinyStore

let viewController = ShippingServiceListViewController()

viewController.elements = [ 
    .item(
        TSShippingServiceViewController(
            service: DefaultShippingService(
                isSelected: false,
                title: "UPS",
                price: 3.0
            )
        )
    ),
    .item(
        TSShippingServiceViewController(
            service: DefaultShippingService(
                isSelected: false,
                title: "DHL Express",
                price: 5.0
            )
        )
    )
]

viewController.view.backgroundColor = .white

PlaygroundPage.current.liveView = viewController
