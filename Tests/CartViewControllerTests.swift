//
//  CartViewControllerTests.swift
//  TinyStoreTests
//
//  Created by Roy Hsu on 2018/12/14.
//

// MARK: - CartViewControllerTests

import XCTest

@testable import TinyStore

internal final class CartViewControllerTests: XCTestCase {
    
    internal final func testTotalAmount() {
        
        let promise = expectation(description: "Get notified while total amount changes.")
        
        let controller = CartViewController()
        
        controller.loadViewIfNeeded()
        
        XCTAssertEqual(
            controller.totalAmount,
            0.0
        )
        
        controller.totalAmountDidChange = { controller in
            
            promise.fulfill()
            
            XCTAssertEqual(
                controller.totalAmount,
                13.0
            )
            
        }
        
        controller.elements = [
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
            )
        ]
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
