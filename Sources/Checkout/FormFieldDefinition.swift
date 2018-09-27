//
//  FormFieldDefinition.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - FormFieldDefinition

public enum FormFieldDefinition<RawValue> {
    
    case required(FormField<RawValue>)
    
    #warning("not implemented. this should validate if and only if user enter value.")
    case optional
    
}

public extension FormFieldDefinition {
    
    public var rawValue: RawValue? {
        
        switch self {
            
        case let .required(field): return field.rawValue
            
        case .optional: return nil
            
        }
        
    }
    
}
