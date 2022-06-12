//
//  AddInvoiceCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 12/06/22.
//

import UIKit

class AddInvoiceCollectionViewCell: UICollectionViewCell {
 
    private struct Constatns {
        static let cameraIconSize = CGFloat(70)
    }
    
    let cameraImage = UIImageView().withAutoLayout() as! UIImageView
    
    init() {
        super.init(frame: .zero)
        self.configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(self.cameraImage)
        self.cameraImage.constraintHeight(constant: Constatns.cameraIconSize)
        self.cameraImage.constraintWidth(constant: Constatns.cameraIconSize)
        self.cameraImage.centerXToSuper()
        self.cameraImage.centerYToSuper()
        self.cameraImage.image = UIImage(named: "cameraIcon")
    }
}
