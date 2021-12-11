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
        // попытка загрузки переиспользуемой ячейки
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellIdentifier") else {
            print("Создаём новую ячейку для строки: \(indexPath.row)")
            
            // получаем содержимое ячейки
            var newCell = UITableViewCell(style: .default, reuseIdentifier: "ContactCellIdentifier")
            
            // конфигурируем ячейку
            configure(cell: &newCell, for: indexPath)
            
            // возвражаем сконфигурированный экземпляр ячейки
            return newCell
        }
        
        print("Используем старую ячейку для строки с индексом: \(indexPath.row)")
        // конфигурируем ячейку
        configure(cell: &cell, for: indexPath)
        // возвражаем сконфигурированный экземпляр ячейки
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "Строка \(indexPath.row)"
        cell.contentConfiguration = configuration
    }
}
