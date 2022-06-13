//
//  CoreDataInvoiceTests.swift
//  InvoiceManagerTests
//
//  Created by Lazaro Neto on 13/06/22.
//

import XCTest
import CoreData
@testable import InvoiceManager

class CoreDataInvoiceTests: XCTestCase {

    private struct Constants {
        static let name = "Name Test"
        static let client = "Name Test"
        static let dateFormatt = "dd/MM/yyyy"
    }
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var moc: NSManagedObjectContext!
    private var invoice: InvoiceEntity!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.moc =  appDelegate.persistentContainer.viewContext
        
        self.invoice = InvoiceEntity(context: moc)
        self.invoice.name = Constants.name
        self.invoice.client = Constants.name
        self.invoice.image = ""
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatt
        self.invoice.date = formatter.string(from: Date())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        moc.delete(invoice)
        _ = try? moc.save()
    }

    func testExample() throws {
        
        moc.insert(self.invoice)
        
        do {
            try moc.save()
        } catch let error {
            return assertionFailure("Did not save - \(error.localizedDescription)")
        }
        
        let predicate = NSPredicate(format: "name == %@ AND client == %@ AND date == %@",
                                    argumentArray:[Constants.name, Constants.client, ""])
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InvoiceEntity")
        request.predicate = predicate
        
        guard let result = try? moc.fetch(request) else {
            return assertionFailure("Did not fetch")
        }
        
        XCTAssertTrue(result.isEmpty, "Result empty")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
