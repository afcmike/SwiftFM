//
//  FMQuery.swift
//  SwiftFM
//
//  Created by Brian Hamm on 2/14/22.
//

import Foundation


// MARK: - Find Requests or Get RecordId -> .data?

public struct FMQuery {
    
    public struct Result: Codable {
        let response: Response
        let messages: [Message]
    }
    
    public struct Message: Codable {
        let code: String
        let message: String
    }
    
    public struct Response: Codable {
        let dataInfo: DataInfo?
        let data: [Record]?  // <-- ✨ SwiftFM.query() method return
    }
    
    public struct DataInfo: Codable {
        let database: String
        let layout: String
        let table: String
        let totalRecordCount: Int
        let foundCount: Int
        let returnedCount: Int
    }
    
    public struct Record: Codable {
        let recordId: String  // <-- ✨ useful as a \.keyPath in SwiftUI List views... ie. List(artists, id: \.recordId)
        let modId: String
        let fieldData: FieldData
        let portalDataInfo: [PortalDataInfo]?
        let portalData: PortalData
    }
    
    
    
    // 👇 these are your Swift model property names. Map your Filemaker field names with CodingKey string literals.
    
    public struct FieldData: Codable {
        let myProperty: String
        // let address: String
        // ...
        
        public enum CodingKeys: String, CodingKey {
            case myProperty
            // case name = "street_address"
            // ...
        }
    }
    
    
    
    public struct PortalDataInfo: Codable {
        let portalObjectName: String
        let database: String
        let table: String
        let foundCount: Int
        let returnedCount: Int
    }
    
    /*
     ⚠️ defining Codable portal models is -possible- but kind of a PITA, to be honest. I just fire a second query() on the portal base table instead. Way more direct, and easier, IMO. Anyhoo, I'm including a Codable portal example below, so you can see the structure. Use them if you want.
    */
    
    
    // change `myPortalObjectName` and add your properties to `PortalRecord`.
    
    public struct PortalData: Codable {
        let myPortalObjectName: [PortalRecord]?
    }
    
    
    // these are your Swift model property names. Map your Filemaker portal field names with CodingKey string literals.
    
    public struct PortalRecord: Codable {
        let recordId: String
        let modId: String
        // let myProperty: String
        // ...
        
        public enum CodingKeys: String, CodingKey {
            case recordId
            case modId
            // case myProperty = "relatedTable::fieldName"
            // ...
        }
        
    }
    
}
