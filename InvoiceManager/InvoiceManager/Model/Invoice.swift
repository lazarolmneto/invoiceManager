//
//  Invoice.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit
import CoreData

struct Invoice {

    let invoiceImage: String
    let id: String
    let name: String
    let client: String
    let date: String
    
    init(image: String,
         name: String,
         client: String,
         date: String) {
        
        self.invoiceImage = image
        self.id = ""
        self.name = name
        self.client = client
        self.date = date
    }
    
    init(from entity: InvoiceEntity) {
        
        self.invoiceImage = entity.image ?? ""
        self.id = entity.objectID.uriRepresentation().absoluteString
        self.name = entity.name ?? ""
        self.client = entity.client ?? ""
        self.date = entity.date ?? ""
    }
}
