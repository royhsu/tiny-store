//
//  CheckoutForm.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutForm

public struct CheckoutForm: ExpressibleByArrayLiteral {

    internal let storage: CheckoutStorage

    public init(
        fields: [CheckoutField]
    ) { self.storage = CheckoutStorage(elements: fields) }

    public init(arrayLiteral fields: CheckoutField...) { self.init(fields: fields) }
    
    public func export(_ resultType: CheckoutFormResult.Type) throws -> CheckoutFormResult {
        
        let fields = storage.elements.map { $0.value }
        
        #warning("validate all fields.")
        
//        try fields.forEach { field in
//            
//            switch field {
//                
//            case let .shipping(field):
//                
//            case let .recipient(field):
//                
//                field.
//                
//            }
//            
//        }
        
        return try resultType.init(
            AnyCollection(fields)
        )
        
    }

}
