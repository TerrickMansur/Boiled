//
//  Coordinator.swift
//  Boiled
//
//  Created by Terrick Mansur on 3/23/19.
//

import Foundation

public enum Coordinator {}

public protocol ProvidesFooterComponent {
    var footer: UIViewController? { get }
    var footerHeight: CGFloat { get }
}

public protocol HasFooterViewProtocol {
    
    var footerView: UIView! { get }
    var footerHeight: NSLayoutConstraint! { get }
}

extension HasFooterViewProtocol where Self: UIViewController {
    func addFooter(footerProvider: ProvidesFooterComponent) {
        if let footer = footerProvider.footer {
            // Add the footer view
            footer.view.frame = CGRect(x: 0, y: 0, width: footerView.frame.width, height: footerView.frame.height)
            self.addChild(footer)
            footerView.addSubview(footer.view)
            
            self.footerHeight.constant = footerProvider.footerHeight
        } else {
            self.footerHeight.constant = 0
        }
    }
}
