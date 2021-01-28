//
//  ONTPeopleGroupModel.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 31.12.2020.
//

import Foundation

class ONTPeopleGroupModel: Decodable  {
    var groups: [Group]
    
    enum CodingKeys: String, CodingKey {
        case groups
    }
}

struct Person: Decodable {
    var firstName: String
    var lastName: String
    var statusIcon: String
    var statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case statusIcon
        case statusMessage
    }
}

struct Group: Decodable {
    var groupName: String
    var people: [Person]
    
    enum CodingKeys: String, CodingKey {
        case groupName
        case people
    }
}


