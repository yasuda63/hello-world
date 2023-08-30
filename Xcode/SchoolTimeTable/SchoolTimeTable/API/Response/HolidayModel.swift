//
//  HolidayModel.swift
//  SchoolTimeTable
//
//  Created by student on 2023/07/05.
//

import Foundation

struct HolidayModel: Codable {
    
    var date: String
    
    var week: String
    
    var weekEn: String
    
    var name: String
    
    var nameEn: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case week
        case weekEn = "week_en"
        case name
        case nameEn = "name_en"
    }
    
}

