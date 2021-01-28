//
//  ONTContactListPresenter.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 31.12.2020.
//

import Foundation

class ONTContactListPresenter {
    
    private weak var viewController: ONTContactsListTVC?
    private let model: ONTContactListModel
    private let loader: ONTSourceLoaderProtocol
    
    init(_ controller: ONTContactsListTVC, _ model: ONTContactListModel, _ loader: ONTSourceLoaderProtocol) {
        self.model = model
        self.viewController = controller
        self.loader = loader
    }
}

extension ONTContactListPresenter: ONTContactListDataProtocol {
    
    ///Reset filter fields in this model
    /// - Parameters:
    ///   - index: selected section index of UISeatrchBar
    ///   - searchString: text to seach from   UISeatrchBar
    func setNewFilter(_ index: Int, _ searchString: String) {
        self.model.setFilter(index, searchString)
        self.reloadListWithPreparedData()
    }
    
    
    
    /// just to initiate reloading on viewcontroller
    func reloadListWithPreparedData () {
        DispatchQueue.main.async {
            self.viewController?.reloadListData()
        }
    }
    
    
    /// start process of loading data from external resources, parce the result and prepare model for list controller
    func reloadFromSource() {
        loader.requestDataFromSource(handler: { [weak self] (groupModel) in
            self?.model.reloadFromSource(groupModel)
            self?.setNewFilter(0, "")
        })
    }
}
