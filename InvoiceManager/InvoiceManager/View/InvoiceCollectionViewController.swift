//
//  InvoiceCollectionViewController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 09/06/22.
//

import UIKit
import CoreData

class InvoiceCollectionViewController: UIViewController {

    //Constants - InvoiceCollectionViewController
    private struct Constants {
        static let heightMultiplier = 1.22
        static let numberOfSections = 1
        static let collectionHorizontalPadding = CGFloat(10)
        static let collectionTopPadding = CGFloat(80)
        static let cellIdentifier = "invoiceCell"
        static let cellIdentifierAddInvoice = "addInvoiceCell"
        static let alertTitle = "Choose Image"
        static let albumTitle = "Album"
        static let cameraTitle = "Camera"
        static let cancelTitle = "Cancel"
        static let dateFormat = "dd/MM/yyyy"
        static let title = "Invoices"
    }
    
    //Layout
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout()).withAutoLayout()
    private let imagePicker = UIImagePickerController()
    private let alert = UIAlertController(title: Constants.alertTitle,
                                          message: nil,
                                          preferredStyle: .actionSheet)
    
    //Coordinator
    private var coordinator: CoordinatorInvoiceDetail?
    
    //Logic
    var logicController: InvoiceCollectionLogicController?
    
    init(coordinator: CoordinatorInvoiceDetail,
         logic: InvoiceCollectionLogicController?) {
        
        self.coordinator = coordinator
        self.logicController = logic
        super.init(nibName: nil, bundle: nil)
        self.title = Constants.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logicController?.loadInvoices()
    }

    private func setup() {
        self.view.backgroundColor = .white
        self.setupLogicController()
        self.setupCollectionView()
        self.addSubViews()
        self.setupPicker()
    }
    
    private func setupLogicController() {
        self.logicController?.setDelegate(delegate: self)
    }
    
    private func addSubViews() {
        
        self.view.addSubview(self.collectionView)
        self.setupLayout()
    }
    
    private func setupLayout() {
        
        self.collectionView.constraintTop(to: self.view, constant: Constants.collectionTopPadding)
        self.collectionView.constraintBottom(to: self.view)
        self.collectionView.constraintTrailing(to: self.view, constant:  -Constants.collectionHorizontalPadding)
        self.collectionView.constraintLeading(to: self.view, constant: Constants.collectionHorizontalPadding)
    }
    
    private func setupCollectionView() {
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(AddInvoiceCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifierAddInvoice)
        self.collectionView.register(InvoiceCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setupPicker() {
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = false
        
        let actionSavedPhotosAlbum = UIAlertAction(title: Constants.albumTitle, style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                
                guard let self = self else { return }
                self.presentImagePicker(with: .savedPhotosAlbum)
            }
        }
        
        let actionCamera = UIAlertAction(title: Constants.cameraTitle, style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                
                guard let self = self else { return }
                self.presentImagePicker(with: .camera)
            }
        }
        
        let cancelActtion = UIAlertAction(title: Constants.cancelTitle, style: .destructive) { [weak self] _ in
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
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.logicController?.invoices.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            return self.returnAddInvoiceCell(collectionView, cellForItemAt: indexPath)
        }
        
        guard let invoice = self.logicController?.invoices[indexPath.item - 1] else { return UICollectionViewCell() }
        return returnInvoiceCell(collectionView,
                                 cellForItemAt: indexPath,
                                 invoice: invoice)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            
            self.showPickerAlert()
        } else {
            
            guard let invoice = self.logicController?.invoices[indexPath.item - 1],
                    let context = self.logicController?.context else { return }
            
            self.coordinator?.goToInvoiceDetail(from: self,
                                                invoice: invoice,
                                                coordinator: self.coordinator as? Coordinator,
                                                context: context, style: .edit)
        }
    }
    
    private func returnAddInvoiceCell(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> AddInvoiceCollectionViewCell{
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifierAddInvoice, for: indexPath) as? AddInvoiceCollectionViewCell {
            return cell
        }
        
        return AddInvoiceCollectionViewCell()
    }
    
    private func returnInvoiceCell(_ collectionView: UICollectionView,
                                   cellForItemAt indexPath: IndexPath,
                                   invoice: InvoiceEntity) -> InvoiceCollectionViewCell{
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? InvoiceCollectionViewCell {
            cell.redraw(with: invoice)
            return cell
        }
        
        return InvoiceCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
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
        
        picker.dismiss(animated: true)
        DispatchQueue.main.async {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                guard let str = pickedImage.jpegData(compressionQuality: 0.7)?.base64EncodedString(options: .lineLength64Characters),
                      let context = self.logicController?.context else { return }
                
                let formatter = DateFormatter()
                formatter.dateFormat = Constants.dateFormat

                let entity = InvoiceEntity(context: context)
                entity.date = formatter.string(from: Date())
                entity.image = str
                
                self.coordinator?.goToInvoiceDetail(from: self,
                                                    invoice: entity,
                                                    coordinator: self.coordinator as? Coordinator,
                                                    context: context,
                                                    style: .add)
            }
        }
    }
}

//MARK: InvoiceCollectionLogicControllerDelegate
extension InvoiceCollectionViewController: InvoiceCollectionLogicControllerDelegate {
    
    func didFetchData() {
        self.collectionView.reloadData()
    }
}
