//
//  ONTSourceLoaderProtocol.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 01.01.2021.
//

import Foundation

protocol ONTSourceLoaderProtocol {
    func requestDataFromSource (handler: @escaping (_ model:ONTPeopleGroupModel?)->())
}

extension ONTSourceLoaderProtocol {
    
    
    /// load and parse data from external source and provide the result to listcontroller model adoptiog
    /// - Parameter handler: coplition closure
    func requestDataFromSource (handler: @escaping (_ model:ONTPeopleGroupModel?)->()) {
        DispatchQueue.global(qos: .utility).async{
            let jsonData = ONTJSONDummyData.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            let groupModel = try? decoder.decode(ONTPeopleGroupModel.self, from: jsonData)
            handler(groupModel)
        }
    }
}
