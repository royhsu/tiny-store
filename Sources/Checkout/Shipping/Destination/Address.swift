//
//  Address.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - Address


public protocol ShippingAddress {
    
    var title: Content<String> { get }
    
    var postalCode: Content<String> { get }
    
    var country: Content<String> { get }
    
    var state: Content<String> { get }
    
    var city: Content<String> { get }
    
    var line1: Content<String> { get }
    
    var line2: Content<String> { get }
    
}

struct Address: ShippingAddress {
    
    let title: Content<String>
    
    let postalCode: Content<String>
    
    let country: Content<String>
    
    let state: Content<String>
    
    let city: Content<String>
    
    let line1: Content<String>
    
    let line2: Content<String>
    
    init(
        title: String,
        postalCode: String,
        country: String,
        state: String,
        city: String,
        line1: String,
        line2: String
        ) {
        
        self.title = Content(value: title)
        
        self.postalCode = Content(value: postalCode)
        
        self.country = Content(value: country)
        
        self.state = Content(value: state)
        
        self.city = Content(value: city)
        
        self.line1 = Content(value: line1)
        
        self.line2 = Content(value: line2)
        
    }
    
}
