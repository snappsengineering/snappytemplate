//
//  Activity.swift
//
//  Created by snapps
//

import Foundation

struct Activity: Storable {
    var activityId: String
    var date: Date
    var attributes: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case activityId
        case date
        case attributes
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activityId = try values.decode(String.self, forKey: .activityId)
        date = try values.decode(Date.self, forKey: .date)
        let data = try values.decode(Data.self, forKey: .attributes)
        attributes = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(activityId, forKey: .activityId)
        try container.encode(date, forKey: .date)
        let data = try JSONSerialization.data(withJSONObject: attributes, options: [])
        try container.encode(data, forKey: .attributes)
    }
    
    init(attributes: [String: Any], date: Date) {
        self.activityId = UUID.init().uuidString
        self.date = date
        self.attributes = attributes
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool{
        return lhs.activityId == rhs.activityId
    }
}
