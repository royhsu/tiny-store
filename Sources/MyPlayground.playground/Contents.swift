import TinyStore
import PlaygroundSupport

let viewController = TSShippingDestinationCardViewController(
    recipient: DefaultShippingRecipient(
        firstName: "Roy",
        lastName: "Hsu"
    ),
    address: DefaultShippingAddress(
        country: Taiwan(),
        state: TaiwanState.taipeiCity,
        district: TaipeiCityDistrict.xinYiDistrict,
        street1: "Shifu Rd.",
        street2: "No.45"
    )
)

viewController.view.backgroundColor = .white

PlaygroundPage.current.liveView = viewController
