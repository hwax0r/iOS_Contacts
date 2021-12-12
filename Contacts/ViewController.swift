//
//  ViewController.swift
//  Contacts
//
//  Created by David Sergeev on 09.12.2021.
//

import UIKit

class ViewController: UIViewController {
    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort{ $0.title < $1.title }
            // сохранение контактов в хранилище
            storage.save(contacts: contacts)
        }
    }
    var storage: ContactStorageProtocol!
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()
    }
    
    @IBAction func showNewContactAlert() {
        // создание Alert Controller
        let alertController = UIAlertController(title: "Создайте новый контакт",
                                                message: "Введите имя и телефон",
                                                preferredStyle: .alert)
        // Добавляем первое текстовое поле в Alert Controller
        alertController.addTextField{ textField in
            textField.placeholder = "Имя"
        }
        // Добавляем второе текстовое поле в Alert Controller
        alertController.addTextField{ textField in
            textField.placeholder = "Номер телефона"
        }
        // создаём конопку создания контакта
        let createButton = UIAlertAction(title: "Создать", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text else {
                return
            }
            // создаём новый контакт
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        // Кнопка отмена
        let cancelButton = UIAlertAction(title: "Отмена",
                                         style: .cancel,
                                         handler: nil)
        
        // Добавляем кнопки в Alert Controller
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        
        // отображаем Alert Controller
        self.present(alertController, animated: true, completion: nil)
    }

    private func loadContacts() {
        contacts = storage.load()
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") {
            _,_,_ in
            // удалить контакт
            self.contacts.remove(at: indexPath.row)
            //заново формируем табличное представление
            tableView.reloadData()
        }
        // экземпляр, описывающий возможные действия
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
