//
//  TaiwanCity.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - TaiwanCity

public enum TaiwanCity: City {
    
    case taipei
    
    case tainan
    
    case yunlin
    
    public var name: String {
        
        switch self {
            
        case .taipei: return "Taipei"
            
        case .tainan: return "Tainan"
            
        case .yunlin: return "Yunlin"
            
        }
        
    }
    
}
