//
//  ONTContactsListTVC.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 30.12.2020.
//

import UIKit

class ONTContactsListTVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var model: ONTContactListModel?
    private var presenter: ONTContactListDataProtocol?
    
    func setModel(_ model: ONTContactListModel) {
        self.model = model
    }
    func setPresenter(_ presenter: ONTContactListDataProtocol) {
        self.presenter = presenter
    }
    
    
    /// it is called from presenter to refresh data at the and of the data processing
    func reloadListData() {
        self.tableView.reloadData()
    }
    
    func filterData(_ searchBar: UISearchBar) {
        self.presenter?.setNewFilter(searchBar.selectedScopeButtonIndex, searchBar.text ?? "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.reloadFromSource()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50.0;
        
        let headerNib = UINib.init(nibName: String(describing:ONTContactsListSectionHeader.self), bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(UINib(nibName: String(describing: ONTContactsListCell.self),
                                 bundle: nil),
                           forCellReuseIdentifier: "ONTContactsListCell")
    }
    
    
}



extension ONTContactsListTVC: UITableViewDelegate, UITableViewDataSource {
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! ONTContactsListSectionHeader
        headerView.title.text = model?.storedFilter?[section].groupName
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.storedFilter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.storedFilter?[section].people.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ONTContactsListCell", for: indexPath) as! ONTContactsListCell
        cell.setUpData( model?.storedFilter?[indexPath.section].people[indexPath.row] )
        return cell
    }
    
}

extension ONTContactsListTVC: UISearchBarDelegate {
    //MARK:- SEARCH BAR DELEGATE METHOD FUNCTION
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        self.filterData(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterData(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.filterData(searchBar)
    }
}
