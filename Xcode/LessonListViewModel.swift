//
//  LessonListViewModel.swift
//  SchoolTimeTable
//
//  Created by student on 2023/05/10.
//

import Foundation

struct LessonListViewModel {
    
    enum DayOfWeek: Int, CaseIterable {
        case monday
        case thuesday
        case wednesday
        case thursday
        case friday
        
        func fetchLabel() -> String {
            switch self {
            case .monday:
                return "月曜日"
            case .thuesday:
                return "火曜日"
            case .wednesday:
                return "水曜日"
            case .thursday:
                return "木曜日"
            case .friday:
                return "金曜日"
            }
        }
    }
    
    var monday: [LessonDetailViewModel]
    
    var thuesday: [LessonDetailViewModel]
    
    var wednesday: [LessonDetailViewModel]
    
    var thursday: [LessonDetailViewModel]
    
    var friday: [LessonDetailViewModel]
    
    func fetch(item: DayOfWeek) -> [LessonDetailViewModel] {
        switch item {
        case .monday:
            return monday
        case .thuesday:
            return thursday
        case .wednesday:
            return wednesday
        case .thuesday:
            return thuesday
        case .friday:
            return friday
        }
    }
    
}
