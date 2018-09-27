//
//  CheckoutDestination.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutDestination

public enum CheckoutDestination: Destination {

    case cityPicker(
        handler: (City) -> Void
    )

}
