//
//  DashboardAction.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/22.
//

// MARK: - DashboardAction

public protocol DashboardAction {
    
    var title: Content<String> { get }
    
    var handler: ( () -> Void )? { get set }
    
}
