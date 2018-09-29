//
//  CheckoutShippingAction.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingAction

public enum CheckoutShippingAction: Action {

    case updateField(CheckoutShippingField)

    case showPostalCodePicker(CheckoutShippingField)
    
    case showCityPicker(CheckoutShippingField)

}
