//
//  InvoiceCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 12/06/22.
//

import UIKit

class InvoiceCollectionViewCell: UICollectionViewCell {
    
    private struct Constatns {
        //TODO: apply new constatns
    }
    
    //Layout
    let invoiceImage = UIImageView().withAutoLayout() as! UIImageView
    
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
        self.addSubview(self.invoiceImage)
        self.invoiceImage.edgeToSuperView()
    }
    
    func redraw(with invoice: InvoiceEntity) {
        if let data = Data(base64Encoded: invoice.image ?? "", options: .ignoreUnknownCharacters) {
            let image = UIImage(data: data)
            self.invoiceImage.image = image
        }
    }
}
