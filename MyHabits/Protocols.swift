//
//  Protocols.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 03.07.2021.
//

import Foundation

protocol ReloadDelegate: class {
    func reloadCollection()
}

protocol CallFromEditToDetail: class {
    func callFromEditToDetail()
}
