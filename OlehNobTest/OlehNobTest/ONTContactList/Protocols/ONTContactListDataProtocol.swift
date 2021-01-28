//
//  ONTContactListDataProtocol.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 01.01.2021.
//

import Foundation

protocol ONTContactListDataProtocol {
    func setNewFilter(_ index: Int, _ searchString: String)
    func reloadListWithPreparedData ()
    func reloadFromSource()
}


