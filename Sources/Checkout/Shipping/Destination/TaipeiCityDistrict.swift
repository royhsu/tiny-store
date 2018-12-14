//
//  TaipeiCityDistrict.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - TaipeiCityDistrict

public enum TaipeiCityDistrict: String, District {

    case daAnDistrict = "106"
    
    case xinYiDistrict = "110"

    public var name: String {

        switch self {

        case .daAnDistrict:

            return NSLocalizedString(
                "Da'an District",
                comment: ""
            )
            
        case .xinYiDistrict:
            
            return NSLocalizedString(
                "Xin Yi District",
                comment: ""
            )

        }

    }

}
