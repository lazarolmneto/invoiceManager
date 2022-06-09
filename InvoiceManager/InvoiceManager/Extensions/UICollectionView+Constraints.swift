//
//  UICollectionView+Constraints.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 09/06/22.
//

import UIKit

extension UICollectionView {

    override func withAutoLayout() -> UICollectionView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
}
