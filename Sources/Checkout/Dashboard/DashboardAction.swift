//
//  DashboardAction.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/22.
//

// MARK: - DashboardAction

public struct DashboardAction {
    
    public let title: Content<String>
    
    public var handler: ( () -> Void )?
    
    public init(
        title: String? = nil,
        handler: ( () -> Void )? = nil
    ) {
        
        self.title = Content(value: title)
        
        self.handler = handler
        
    }
    
}

