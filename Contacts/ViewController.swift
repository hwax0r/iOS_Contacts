//
//  ViewController.swift
//  Contacts
//
//  Created by David Sergeev on 09.12.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
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
            cell.textLabel?.text = "Строка \(indexPath.row)"
            return
        }
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "Строка \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
}
