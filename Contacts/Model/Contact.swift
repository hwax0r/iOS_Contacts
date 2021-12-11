//
//  Contact.swift
//  Contacts
//
//  Created by David Sergeev on 11.12.2021.
//

import Foundation

protocol ContactProtocol {
    /// Имя
    var title: String { get set }
    /// Номер телефона
    var phone: String { get set }
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}
