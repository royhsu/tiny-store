//
//  Taiwan.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Taiwan

import TinyStore

public enum Taiwan: City {
    
    case taipei
    
    public var name: String {
        
        switch self {
            
        case .taipei: return "Taipei"
            
        }
        
    }
    
}
