//
//  ViewController.swift
//  Contacts
//
//  Created by David Sergeev on 09.12.2021.
//

import UIKit

class ViewController: UIViewController {
    private var contacts: [ContactProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContacts()
    }

    private func loadContacts() {
        contacts.append(Contact(title: "Валя Дизайнер", phone: "+77658330945"))
        contacts.append(Contact(title: "Стив Джобс", phone: "+14089733091"))
        contacts.append(Contact(title: "Антон Флексер", phone: "+76664442200"))
        contacts.sort{$0.title < $1.title}
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "ContactCellIdentifier") {
            print("Используем старую ячейку для строки: \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаём новую ячейку для строки: \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "ContactCellIdentifier")
        }
        
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        guard #available(iOS 14, *) else {
            // имя контакта
            cell.textLabel?.text = contacts[indexPath.row].title
            // номер телефона контакта
            cell.detailTextLabel?.text = contacts[indexPath.row].phone
            return
        }
        
        var configuration = cell.defaultContentConfiguration()
        // имя контакта
        configuration.text = contacts[indexPath.row].title
        // номер телефона контакта
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}
