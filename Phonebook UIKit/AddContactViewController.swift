//
//  AddContactViewController.swift
//  Phonebook UIKit
//
//  Created by besim on 13/04/2024.
//

import UIKit

class AddContactViewController: UIViewController {
    
    var saveContactHandler: ((Contact) -> Void)?

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone number"
        textField.borderStyle = .roundedRect
        return textField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupNavigationBar()
        
    }

    private func setupNavigationBar() {
        navigationItem.title = "Add Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, phoneNumberTextField])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
    }
    
    @objc private func saveContact() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            print("Add name and phone number")
            return
        }
        let newContact = Contact(name: name, phoneNumber: phoneNumber)
        saveContactHandler?(newContact)
        dismiss(animated: true)
    }
}

