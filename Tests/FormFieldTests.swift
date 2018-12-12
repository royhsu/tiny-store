//
//  FormFieldTests.swift
//  TinyStoreTests
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - FormFieldTests

import XCTest

@testable import TinyStore

internal final class FormFieldTests: XCTestCase {

    internal final func testValidateRequiredField() {

        var field = MessageField(
            value: nil,
            rules: [ .notEmpty ],
            definition: .required
        )

        XCTAssertThrowsError(
            try field.validate()
        ) { error in

            if case NotNilError.isNil = error {

                XCTSuccess()

                return

            }

            XCTFail("Unexpected error: \(error)")

        }

        field.value = ""

        XCTAssertThrowsError(
            try field.validate()
        ) { error in

            if case NotEmptyError.isEmpty = error {

                XCTSuccess()

                return

            }

            XCTFail("Unexpected error: \(error)")

        }

        field.value = "hello"

        XCTAssertEqual(
            try field.validate(),
            "hello"
        )

    }

    internal final func testValidateOptionalField() {

        var field = MessageField(
            value: nil,
            rules: [ .notEmpty ],
            definition: .optional
        )

        XCTAssertEqual(
            try field.validate(),
            nil
        )

        field.value = ""

        XCTAssertThrowsError(
            try field.validate()
        ) { error in

            if case NotEmptyError.isEmpty = error {

                XCTSuccess()

                return

            }

            XCTFail("Unexpected error: \(error)")

        }

        field.value = "hello"

        XCTAssertEqual(
            try field.validate(),
            "hello"
        )

    }

}
