//
//  UILabel+ValueRenderable.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MARK: - ValueRenderable

extension UILabel: ValueRenderable {
    
    public final func render(with text: String?) { self.text = text }
    
}
