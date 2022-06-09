//
//  UIView+Constrains.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 09/06/22.
//

import UIKit

extension UIView {

    func withAutoLayout() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func constraintTop(to viewTop: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: viewTop.topAnchor, constant: constant).isActive = true
    }
    
    func constraintBottom(to viewBottom: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: viewBottom.topAnchor, constant: constant).isActive = true
    }
    
    
    func constraintLeading(to viewLeading: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: viewLeading.topAnchor, constant: constant).isActive = true
    }
    
    func constraintTrailing(to viewTrailing: UIView, constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: viewTrailing.topAnchor, constant: constant).isActive = true
    }

}
