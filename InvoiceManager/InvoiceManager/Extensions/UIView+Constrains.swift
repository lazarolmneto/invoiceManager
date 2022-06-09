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
    
    func constraintBottom(to viewBottom: UIView, constant: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: viewBottom.bottomAnchor, constant: constant).isActive = true
    }
    
    
    func constraintLeading(to viewLeading: UIView, constant: CGFloat = 0) {
        self.leadingAnchor.constraint(equalTo: viewLeading.leadingAnchor, constant: constant).isActive = true
    }
    
    func constraintTrailing(to viewTrailing: UIView, constant: CGFloat = 0) {
        self.trailingAnchor.constraint(equalTo: viewTrailing.trailingAnchor, constant: constant).isActive = true
    }

}
