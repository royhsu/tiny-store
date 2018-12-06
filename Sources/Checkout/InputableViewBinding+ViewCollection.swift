//
//  InputableViewBinding+ViewCollection.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - InputableViewBinding

extension InputableViewBinding: ViewCollection {
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return view }
    
}
