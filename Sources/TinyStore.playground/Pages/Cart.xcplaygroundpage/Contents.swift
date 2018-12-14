import PlaygroundSupport
import TinyStore

let viewController = CartViewController()

viewController.view.backgroundColor = .white

viewController.elements = [
    .item(
        TSCartItemViewController(
            item: Apparel(
                isSelected: true,
                title: "Knee-length Wool Skirt",
                color: "Dark Blue",
                size: "S",
                price: 19.0,
                quantity: 1
            )
        )
    ),
    .item(
        TSCartItemViewController(
            item: Apparel(
                isSelected: true,
                title: "Long-sleeved Blouse",
                color: "Light Blue",
                size: "S",
                price: 13.0,
                quantity: 1
            )
        )
    ),
    .item(
        TSCartItemViewController(
            item: Apparel(
                isSelected: true,
                title: "High Heels",
                color: "Purple Diamond",
                size: "8",
                price: 35.0,
                quantity: 1
            )
        )
    )
]

viewController.totalAmountDidChange = { controller in
    
    print("Total amount: ", controller.totalAmount)
    
}

PlaygroundPage.current.liveView = viewController
