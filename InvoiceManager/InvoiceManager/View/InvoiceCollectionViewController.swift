//
//  InvoiceCollectionViewController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 09/06/22.
//

import UIKit

class InvoiceCollectionViewController: UIViewController {

    //Constants - InvoiceCollectionViewController
    private struct Constants {
        static let cellHeight = CGFloat(130)
        static let cellIdentifier = "invoiceCell"
        static let cellIdentifierAddInvoice = "addInvoiceCell"
    }
    
    //Layout
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout()).withAutoLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }

    private func setup() {
        self.view.backgroundColor = .white
        self.setupCollectionView()
        self.addSubViews()
//        self.setupLayout()
    }
    
    private func addSubViews() {
        
        self.view.addSubview(self.collectionView)
        self.setupLayout()
    }
    
    private func setupLayout() {
        
        self.collectionView.constraintTop(to: self.view, constant: 20)
        self.collectionView.constraintBottom(to: self.view)
        self.collectionView.constraintTrailing(to: self.view, constant:  -10)
        self.collectionView.constraintLeading(to: self.view, constant: 10)
    }
    
    private func setupCollectionView() {
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .green
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
}

//MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension InvoiceCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension InvoiceCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = Constants.cellHeight
        let width = (collectionView.frame.width / 2) - 5
        
        return CGSize(width: width, height: height)
    }
}

