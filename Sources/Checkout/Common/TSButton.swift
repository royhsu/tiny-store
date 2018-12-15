//
//  TSButton.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/15.
//

// MARK: - TSButton

open class TSButton: UIButton {
    
    @IBInspectable
    public final var adjustsFontForContentSizeCategory: Bool {
        
        get { return titleLabel?.adjustsFontForContentSizeCategory ?? false }
        
        set { titleLabel?.adjustsFontForContentSizeCategory = newValue }
        
    }
    
}
