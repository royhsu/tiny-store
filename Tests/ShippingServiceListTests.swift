//
//  ShippingServiceListTests.swift
//  TinyStoreTests
//
//  Created by Roy Hsu on 2018/12/13.
//

// MARK: - ShippingServiceListTests

import XCTest

@testable import TinyStore

internal final class ShippingServiceElementCollectionTests: XCTestCase {
    
    internal final func testOnlyOneItemSelectedAtMoment() {
        
        let promise = expectation(description: "The selected index did change.")
        
        let controller = ShippingServiceListViewController()
        
        controller.loadViewIfNeeded()
        
        controller.elements = [
            .item(
                TSShippingServiceViewController(
                    service: DefaultShippingService(
                        isSelected: true,
                        title: "UPS",
                        price: 10.0
                    )
                )
            ),
            .item(
                TSShippingServiceViewController(
                    service: DefaultShippingService(
                        isSelected: true,
                        title: "Express",
                        price: 10.0
                    )
                )
            )
        ]
        
        XCTAssertNil(controller.selectedIndex.value)
        
        for element in controller.elements {
            
            switch element {
                
            case let .item(controller):
                
                XCTAssertEqual(
                    controller.service?.isSelected.value,
                    false
                )
                
            }
            
        }
        
        controller.selectedIndex.value = 1
        
        DispatchQueue.main.async {
            
            promise.fulfill()
        
            for index in 0..<controller.elements.count {
                
                let element: ShippingServiceElement = controller.elements[index]
                
                switch element {
                    
                case let .item(controller):
                    
                    let isSelected = (index == 1)
                    
                    XCTAssertEqual(
                        controller.service?.isSelected.value,
                        isSelected
                    )
                    
                }
                
            }
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
