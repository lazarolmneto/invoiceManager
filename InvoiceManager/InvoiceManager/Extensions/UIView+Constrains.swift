//
//  UIView+Constrains.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 09/06/22.
//

import UIKit

extension UIView {

    @objc func withAutoLayout() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func constraintTop(to viewTop: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: viewTop.topAnchor, constant: constant).isActive = true
    }
    
    func constraintTop(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func constraintBottom(to viewBottom: UIView, constant: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: viewBottom.bottomAnchor, constant: constant).isActive = true
    }
    
    
    func constraintLeading(to viewLeading: UIView, constant: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: viewLeading.leadingAnchor, constant: constant).isActive = true
    }
    
    func constraintTrailing(to viewTrailing: UIView, constant: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: viewTrailing.trailingAnchor, constant: constant).isActive = true
    }

    func constraintHeight(constant: CGFloat = 0) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraintWidth(constant: CGFloat = 0) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func edgeToSuperView() {
        guard let superView = self.superview else { return }
        self.constraintTop(to: superView)
        self.constraintLeading(to: superView)
        self.constraintBottom(to: superView)
        self.constraintTrailing(to: superView)
    }
    
    func centerX(to viewCenter: UIView, constant: CGFloat = 0) {
        self.centerXAnchor.constraint(equalTo: viewCenter.centerXAnchor, constant: constant).isActive = true
    }
    
    func centerY(to viewCenter: UIView, constant: CGFloat = 0) {
        self.centerYAnchor.constraint(equalTo: viewCenter.centerYAnchor, constant: constant).isActive = true
    }
    
    func centerXToSuper(constant: CGFloat = 0) {
    
        if let superView = self.superview {
            self.centerX(to: superView, constant: constant)
        }
    }
    
    func centerYToSuper(constant: CGFloat = 0) {
    
        if let superView = self.superview {
            self.centerY(to: superView, constant: constant)
        }
    }
}
