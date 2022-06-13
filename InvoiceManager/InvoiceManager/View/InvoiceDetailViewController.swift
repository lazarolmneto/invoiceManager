//present
//  InvoiceDetailViewController.swift
//  InvoiceManager
//
//  Created by Lazaro Neto on 11/06/22.
//

import UIKit
import CoreData

class InvoiceDetailViewController: UIViewController {

    public enum Style {
        case add
        case edit
    }
    
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
    let deleteButton: UIButton = UIButton().withAutoLayout() as! UIButton
    
    //style attribute
    let style: Style
    
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
        static let deleteTitle = "Delete"
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
         coordinator: Coordinator?, style: Style = .add) {
        
        self.logicController = logicController
        self.coordinator = coordinator
        self.style = style
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
        self.view.addSubview(self.deleteButton)
        self.setupLayout()
        
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
        gradientLayer.colors = [UIColor.appBlackColor.cgColor, UIColor.clear.cgColor]
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
        self.nameTextField.textColor = .appBlackColor
        
        self.clientTextField.constraintTop(to: self.nameTextField.bottomAnchor,
                                           constant: Constants.textFieldTopPadding)
        self.clientTextField.constraintLeading(to: self.nameTextField)
        self.clientTextField.constraintTrailing(to: self.nameTextField)
        self.clientTextField.constraintHeight(constant: Constants.textFieldHeight)
        self.clientTextField.textColor = .appBlackColor
        
        self.dateTextField.constraintTop(to: self.clientTextField.bottomAnchor,
                                         constant: Constants.textFieldTopPadding)
        self.dateTextField.constraintLeading(to: self.clientTextField)
        self.dateTextField.constraintTrailing(to: self.clientTextField)
        self.dateTextField.constraintHeight(constant: Constants.textFieldHeight)
        self.dateTextField.textColor = .appBlackColor
        
        //save button
        self.saveButton.constraintTop(to: self.dateTextField.bottomAnchor, constant: Constants.textFieldTopPadding)
        self.saveButton.constraintLeading(to: self.clientTextField)
        self.saveButton.constraintTrailing(to: self.clientTextField)
        self.saveButton.constraintHeight(constant: Constants.saveButtonHeight)
        
        //delete button
        self.deleteButton.constraintTop(to: self.saveButton.bottomAnchor, constant: Constants.textFieldTopPadding)
        self.deleteButton.constraintLeading(to: self.clientTextField)
        self.deleteButton.constraintTrailing(to: self.clientTextField)
        self.deleteButton.constraintHeight(constant: Constants.saveButtonHeight)
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
        self.saveButton.backgroundColor = .appBlueColor
        self.saveButton.clipsToBounds = true
        self.saveButton.layer.cornerRadius = Constants.saveButtonHeight / 2
        
        let saveAction = UIAction { [weak self] action in
            guard let self = self else { return }
            
            self.logicController?.saveInvoice(name: self.nameTextField.text ?? "",
                                              client: self.clientTextField.text ?? "",
                                              date: self.dateTextField.text ?? "")
            self.coordinator?.back(from: self)
        }
        
        self.saveButton.addAction(saveAction, for: .touchUpInside)
        
        self.deleteButton.setTitle(Constants.deleteTitle, for: .normal)
        self.deleteButton.setTitleColor(.white, for: .normal)
        self.deleteButton.backgroundColor = .appRedColor
        self.deleteButton.clipsToBounds = true
        self.deleteButton.layer.cornerRadius = Constants.saveButtonHeight / 2
        
        let deleteAction = UIAction { [weak self] action in
            guard let self = self else { return }
            
            self.logicController?.deleteInvoice()
            self.coordinator?.back(from: self)
        }
        
        self.deleteButton.addAction(deleteAction, for: .touchUpInside)
    }
    
    private func setupLayoutData() {
        if let data = Data(base64Encoded: self.logicController?.invoice.image ?? "", options:    .ignoreUnknownCharacters) {
            let image = UIImage(data: data)
            self.imageView.image = image
        }
        
        self.nameTextField.placeholder = Constants.namePlaceHolder
        self.clientTextField.placeholder = Constants.clientPlaceHolder
        self.dateTextField.placeholder = Constants.datePlaceHolder
        
        self.nameTextField.text = self.logicController?.invoice.name
        self.clientTextField.text = self.logicController?.invoice.client
        self.dateTextField.text = self.logicController?.invoice.date
        
        if self.style == .add {
            self.deleteButton.removeFromSuperview()
        }
    }
}
