//
//  ShippingServiceListViewControllerTests.swift
//  TinyStoreTests
//
//  Created by Roy Hsu on 2018/12/13.
//

// MARK: - ShippingServiceListViewControllerTests

import XCTest

@testable import TinyStore

internal final class ShippingServiceListViewControllerTests: XCTestCase {
    
    internal final var observation: Observation?
    
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
                        price: 15.0
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
        
        observation = controller.selectedIndex.observe { result in
            
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
            
            XCTAssertEqual(
                controller.selectedService?.isSelected.value,
                true
            )
            
            XCTAssertEqual(
                controller.selectedService?.title.value,
                "Express"
            )
            
            XCTAssertEqual(
                controller.selectedService?.price.value,
                15.0
            )
            
        }
        
        controller.selectedIndex.value = 1
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
