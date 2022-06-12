//present
//  InvoiceDetailViewController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit
import CoreData

class InvoiceDetailViewController: UIViewController {

    //Logic
    var logicController: InvoiceDetailLogicController?
    
    //Coordinator
    var coordinator: Coordinator?
    
    //Layout
    let parentImageView: UIView = UIView().withAutoLayout()
    let gradientImageView: UIView = UIView().withAutoLayout()
    let imageView: UIImageView = UIImageView().withAutoLayout() as! UIImageView
    let backButton: UIButton = UIButton().withAutoLayout() as! UIButton
    let nameTextField: UITextField = UITextField().withAutoLayout() as! UITextField
    let clientTextField: UITextField = UITextField().withAutoLayout() as! UITextField
    let dateTextField: UITextField = UITextField().withAutoLayout() as! UITextField
    let datePicker: UIDatePicker = UIDatePicker()
    let saveButton: UIButton = UIButton().withAutoLayout() as! UIButton
    
    //Constants - InvoiceDetailViewController
    private struct Constants {
        static let heightMultiplier = CGFloat(1)
        static let heightGradiente = CGFloat(70)
        static let backButtonPadding = CGFloat(20)
        static let backButtonSize = CGFloat(50)
        static let textFieldPadding = CGFloat(20)
        static let textFieldTopPadding = CGFloat(20)
        static let textFieldHeight = CGFloat(40)
        static let saveButtonHeight = CGFloat(50)
        
        //Strings
        static let namePlaceHolder = "Name"
        static let clientPlaceHolder = "Client"
        static let datePlaceHolder = "Date"
        static let dateFormat = "dd/MM/yyyy"
        static let saveTitle = "Save"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLayoutData()
        self.setupDatePicker()
        self.setupButtons()
    }
    
    init(logicController: InvoiceDetailLogicController?,
         coordinator: Coordinator?) {
        
        self.logicController = logicController
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        self.view.backgroundColor = .white
        self.addSubViews()
    }
    
    private func addSubViews() {
        
        self.view.addSubview(self.parentImageView)
        self.parentImageView.addSubview(self.imageView)
        self.parentImageView.addSubview(self.gradientImageView)
        self.parentImageView.addSubview(self.backButton)
        self.view.addSubview(self.nameTextField)
        self.view.addSubview(self.clientTextField)
        self.view.addSubview(self.dateTextField)
        self.view.addSubview(self.saveButton)
        self.setupLayout()
        
        //TODO: REMOVE
        self.parentImageView.backgroundColor = .blue
        self.gradientImageView.backgroundColor = .clear
    }
    
    private func setupLayout() {
        
        //parent image view
        self.parentImageView.constraintTop(to: self.view)
        self.parentImageView.constraintTrailing(to: self.view)
        self.parentImageView.constraintLeading(to: self.view)
        let height = self.view.frame.width * Constants.heightMultiplier
        self.parentImageView.constraintHeight(constant: height)
        
        
        //image view and gradient
        self.imageView.edgeToSuperView()
        self.gradientImageView.constraintTop(to: self.parentImageView)
        self.gradientImageView.constraintTrailing(to: self.parentImageView)
        self.gradientImageView.constraintLeading(to: self.parentImageView)
        self.gradientImageView.constraintHeight(constant: Constants.heightGradiente)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0,
                                     width: self.view.frame.width,
                                     height: Constants.heightGradiente)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        self.gradientImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        //back button
        self.backButton.constraintTop(to: self.parentImageView, constant: Constants.backButtonPadding)
        self.backButton.constraintLeading(to: self.parentImageView, constant: Constants.backButtonPadding)
        self.backButton.constraintWidth(constant: Constants.backButtonSize)
        self.backButton.constraintHeight(constant: Constants.backButtonSize)
        self.backButton.setTitleColor(.white, for: .normal)
        self.backButton.setTitle("X", for: .normal)
        self.backButton.layer.borderColor = UIColor.white.cgColor
        self.backButton.layer.borderWidth = 1
        self.backButton.layer.cornerRadius = Constants.backButtonSize / 2.0
        
        //textfields
        self.nameTextField.constraintTop(to: self.parentImageView.bottomAnchor,
                                         constant: Constants.textFieldPadding)
        self.nameTextField.constraintLeading(to: self.view, constant: Constants.textFieldPadding)
        self.nameTextField.constraintTrailing(to: self.view, constant: -Constants.textFieldPadding)
        self.nameTextField.constraintHeight(constant: Constants.textFieldHeight)
        
        self.clientTextField.constraintTop(to: self.nameTextField.bottomAnchor,
                                           constant: Constants.textFieldTopPadding)
        self.clientTextField.constraintLeading(to: self.nameTextField)
        self.clientTextField.constraintTrailing(to: self.nameTextField)
        self.clientTextField.constraintHeight(constant: Constants.textFieldHeight)
        
        self.dateTextField.constraintTop(to: self.clientTextField.bottomAnchor,
                                         constant: Constants.textFieldTopPadding)
        self.dateTextField.constraintLeading(to: self.clientTextField)
        self.dateTextField.constraintTrailing(to: self.clientTextField)
        self.dateTextField.constraintHeight(constant: Constants.textFieldHeight)
        
        //save button
        self.saveButton.constraintTop(to: self.dateTextField.bottomAnchor, constant: Constants.textFieldTopPadding)
        self.saveButton.constraintLeading(to: self.clientTextField)
        self.saveButton.constraintTrailing(to: self.clientTextField)
        self.saveButton.constraintHeight(constant: Constants.saveButtonHeight)
    }
    
    private func setupDatePicker() {
        self.dateTextField.inputView = self.datePicker
        self.datePicker.datePickerMode = .date
        let action = UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = Constants.dateFormat
            self.dateTextField.text = formatter.string(from: self.datePicker.date)
        })
        self.datePicker.addAction(action, for: .valueChanged)
    }
    
    private func setupButtons() {
        let backAction = UIAction { [weak self] action  in
            guard let self = self else { return }
            self.coordinator?.back(from: self)
        }
        
        self.backButton.addAction(backAction, for: .touchUpInside)
        
        self.saveButton.setTitle(Constants.saveTitle, for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.backgroundColor = .blue
        self.saveButton.clipsToBounds = true
        self.saveButton.layer.cornerRadius = Constants.saveButtonHeight / 2
        
        let saveAction = UIAction { [weak self] action in
            guard let self = self else { return }
            
            self.logicController?.saveInvoice()
            self.coordinator?.back(from: self)
        }
        
        self.saveButton.addAction(saveAction, for: .touchUpInside)
    }
    
    private func setupLayoutData() {
        if let data = Data(base64Encoded: self.logicController?.invoice.invoiceImage ?? "", options:    .ignoreUnknownCharacters) {
            let image = UIImage(data: data)
            self.imageView.image = image
        }
        
        self.nameTextField.placeholder = Constants.namePlaceHolder
        self.clientTextField.placeholder = Constants.clientPlaceHolder
        self.dateTextField.placeholder = Constants.datePlaceHolder
    }
}
