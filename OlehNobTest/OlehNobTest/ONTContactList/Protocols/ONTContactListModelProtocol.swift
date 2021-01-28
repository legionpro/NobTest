//
//  ONTContactListModelProtocol.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 01.01.2021.
//

import Foundation


protocol ONTContactListModelProtocol {
    func setFilter(_ index: Int, _ searchString: String)
    func reloadFromSource(_ groupsData: ONTPeopleGroupModel?)
    func applyFilter() -> [GroupListModel]?
}
