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
        static let heightMultiplier = 1.22
        static let cellIdentifier = "invoiceCell"
        static let cellIdentifierAddInvoice = "addInvoiceCell"
        static let alertTitle = "Choose Image"
    }
    
    //Layout
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout()).withAutoLayout()
    private let imagePicker = UIImagePickerController()
    private let alert = UIAlertController(title: Constants.alertTitle,
                                          message: nil,
                                          preferredStyle: .actionSheet)
    
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
        self.setupPicker()
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
    
    private func setupPicker() {
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = false
        
        let actionSavedPhotosAlbum = UIAlertAction(title: "Album", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                
                guard let self = self else { return }
                self.presentImagePicker(with: .savedPhotosAlbum)
            }
        }
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                
                guard let self = self else { return }
                self.presentImagePicker(with: .camera)
            }
        }
        
        let cancelActtion = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.alert.dismiss(animated: true)
        }
        
        self.alert.addAction(actionSavedPhotosAlbum)
        self.alert.addAction(actionCamera)
        self.alert.addAction(cancelActtion)
    }
    
    private func showPickerAlert() {
        self.present(self.alert, animated: true)
    }
    
    private func presentImagePicker(with sourceType: UIImagePickerController.SourceType) {
        self.alert.dismiss(animated: true)
        self.imagePicker.sourceType = sourceType
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc private func dismissAlert() {
        self.alert.dismiss(animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            
            self.showPickerAlert()
        }
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension InvoiceCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = (collectionView.frame.width / 2) - 5
        let height = width * Constants.heightMultiplier
        
        return CGSize(width: width, height: height)
    }
}

//MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension InvoiceCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
