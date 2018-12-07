//
//  UIKeyboardController.swift
//  TinyKnowledge
//
//  Created by Roy Hsu on 2018/7/6.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIKeyboardController

import UIKit

// TODO: allow overriding.
public final class UIKeyboardController: UIViewController {

    public final var contentViewController: UIViewController? {
        
        didSet {
            
            if let oldViewController = oldValue {
                
                oldViewController.willMove(toParent: nil)
                
                oldViewController.view.removeFromSuperview()
                
                oldViewController.removeFromParent()
                
            }
            
            if let newViewController = contentViewController {
                
                loadViewIfNeeded()
                
                addChild(newViewController)
                
                view.wrapSubview(newViewController.view)
                
                newViewController.didMove(toParent: self)
                
            }
            
        }
        
    }
    
    // TODO: the animation has not implemented yet.
    public final func setContentViewController(
        _ viewController: UIViewController?,
        animated isAnimated: Bool
    ) { contentViewController = viewController }
    
    private final var observations: [NSObjectProtocol] = []
    
    // The .UIKeyboardWillChangeFrame notification will be invoked several times during the keyboard is still showing.
    // Use the cached keyboard frame can help to calculate the correct additional safe area insets.
    private final var cachedKeyboardFrame: CGRect = .zero
    
    deinit { observations.forEach(NotificationCenter.default.removeObserver) }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        observeKeyboardEvents()
        
    }
    
    // MARK: Observer
    
    fileprivate final func observeKeyboardEvents() {
        
        let keyboardWillChangeFrameObservation = NotificationCenter.default.addObserver(
            forName: UIWindow.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main,
            using: { [weak self] notification in
                
                guard
                    let self = self,
                    let keyboardFrame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect
                else { return }
                
                // Restore the additional safe area insets from the cached keyboard frame.
                if #available(iOS 11.0, *) {
                    
                    self.additionalSafeAreaInsets.bottom -= self.cachedKeyboardFrame.height
                    
                    // Update the additional safe area insets with the new keyboard frame
                    self.additionalSafeAreaInsets.bottom += keyboardFrame.height
                    
                }
                else { fatalError("Not implemented.") }
                
                self.cachedKeyboardFrame = keyboardFrame
                
                guard
                    let keyboardAnimationDuration = notification.userInfo?[UIWindow.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
                    let keyboardAnimationOptionRawValue = notification.userInfo?[UIWindow.keyboardAnimationCurveUserInfoKey] as? UInt
                else { return }
                
                let keyboardAnimationOption = UIView.AnimationOptions(rawValue: keyboardAnimationOptionRawValue)
                
                UIView.animate(
                    withDuration: keyboardAnimationDuration,
                    delay: 0.0,
                    options: keyboardAnimationOption,
                    animations: { self.view.layoutIfNeeded() }
                )
                
            }
        )
        
        observations.append(keyboardWillChangeFrameObservation)
        
    }
    
}
