//
//  ONTContactListModel.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 31.12.2020.
//

import Foundation

struct PersonListModel {
    var fullName: String  { get{ return firstName + " " + lastName }}
    var firstName: String
    var lastName: String
    var statusIcon: Status
    var statusMessage: String
    var sex: Sex
}

struct GroupListModel {
    var groupName: String
    var people: [PersonListModel]
}

enum Status: String {
    case online = "contacts_list_status_online"
    case away = "contacts_list_status_away"
    case busy = "contacts_list_status_busy"
    case offline = "contacts_list_status_offline"
    case callForwarding = "contacts_list_call_forward"
    case pending = "contacts_list_status_pending"
}

enum Sex: String {
    case female = "contacts_list_avatar_female"
    case male = "contacts_list_avatar_male"
    case unknown = "contacts_list_avatar_unknown"
}


final class ONTContactListModel {
    private var filterIndex = 0
    private var filterString = ""
    private var groups: [GroupListModel]? // keeps whole data
    var storedFilter: [GroupListModel]? // // keeps data acording to filter
    
    static func getGender(_ name: String) -> Sex {
        var result:Sex
        switch name {
        case "ROY", "BRAYDEN", "WALTER" : result = .male
        case "ERIN" , "LUCY", "BARBARA", "JACQUELINE" : result = .female
        default : result = .unknown
        }
       return result
    }
    
    static func getStatus(_ status: String) -> Status {
        let result : Status
        switch status {
        case "online" : result = .online
        case "away" : result = .away
        case "busy" : result = .busy
        case "offline" : result = .offline
        case "callForwarding" : result = .callForwarding
        default : result = .pending
        }
        return result
    }
}


extension ONTContactListModel: ONTContactListModelProtocol {
    func setFilter(_ index: Int, _ searchString: String) {
        self.filterIndex = index
        self.filterString = searchString
        self.storedFilter = self.applyFilter()
    }
    
    func reloadFromSource(_ groupsData: ONTPeopleGroupModel?) {
        if let grp = groupsData {
        self.groups = grp.groups.map{
            let p = $0.people.map{
                PersonListModel(firstName:$0.firstName,
                                lastName: $0.lastName,
                                statusIcon: ONTContactListModel.getStatus($0.statusIcon),
                                statusMessage: $0.statusMessage,
                                sex: ONTContactListModel.getGender($0.firstName)
                )
            }
            return GroupListModel(
                groupName: $0.groupName,
                people: p)
                }
        }
    }
    
    
    func applyFilter() -> [GroupListModel]? {
        var result: [GroupListModel]?
        if filterString.count > 0 {
        if let grp = groups{
            result = grp.map{
                let p: [PersonListModel]
                switch filterIndex {
                case 0: p = $0.people.filter{ item in item.firstName.lowercased().contains(filterString.lowercased())}
                case 1: p = $0.people.filter{ item in item.lastName.lowercased().contains(filterString.lowercased())}
                default: p = $0.people.filter{ item in item.statusMessage.lowercased().contains(filterString.lowercased())}
                }
            return GroupListModel(
                groupName: $0.groupName,
                people: p)
                }
        }
            return result
        } else {
            return groups
        }
    }
}

