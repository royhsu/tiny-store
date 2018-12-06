//
//  TaiwanPostalCode.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - TaiwanPostalCode

public enum TaiwanPostalCode: String, PostalCode {
    
    case daAnDistrict = "106"
    
    public var name: String {
        
        switch self {
            
        case .daAnDistrict:
            
            return NSLocalizedString(
                "Da'an District",
                comment: ""
            )
            
        }
        
    }
    
}
