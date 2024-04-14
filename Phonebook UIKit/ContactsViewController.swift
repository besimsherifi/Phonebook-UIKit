//
//  ContactsViewController.swift
//  Phonebook UIKit
//
//  Created by besim on 13/04/2024.


import UIKit

struct Contact {
    var name: String
    var phoneNumber: String
}

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    private var contacts: [Contact] = [
        Contact(name: "Alice Smith", phoneNumber: "123-456-7890"),
        Contact(name: "Bob Johnson", phoneNumber: "098-765-4321"),
    ]
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLayout()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
           title = "Contacts"
           navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactTapped))
       }
    
    
    
    @objc private func addContactTapped() {
        let addContactVC = AddContactViewController()
        addContactVC.saveContactHandler = { [weak self] newContact in
            self?.contacts.append(newContact)
            self?.tableView.reloadData()
        }
        let navigationController = UINavigationController(rootViewController: addContactVC)
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        showContactDetail(contact)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func showContactDetail(_ contact: Contact) {
        let detailViewController = UIViewController()
        detailViewController.view.backgroundColor = .white
        detailViewController.title = contact.name

        let nameLabel = UILabel()
        nameLabel.text = "Name: \(contact.name)"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneLabel = UILabel()
        phoneLabel.text = "Phone: \(contact.phoneNumber)"
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        detailViewController.view.addSubview(nameLabel)
        detailViewController.view.addSubview(phoneLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: detailViewController.view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: detailViewController.view.centerYAnchor, constant: -20),
            phoneLabel.centerXAnchor.constraint(equalTo: detailViewController.view.centerXAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        ])

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}



