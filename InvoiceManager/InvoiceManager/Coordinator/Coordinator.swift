//
//  Coordinator.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit

struct Coordinator {

    private init() {}
    
    static let sharedInstance = Coordinator()
    
    func push(from vc: UIViewController, to: UIViewController) {
        vc.navigationController?.pushViewController(to, animated: true)
    }
    
    func present(from vc: UIViewController, to: UIViewController) {
        vc.present(to, animated: true)
    }
    
    func back(from vc: UIViewController) {
        if let nav = vc.navigationController {
            nav.popViewController(animated: true)
        } else {
            vc.dismiss(animated: true)
        }
    }
}
