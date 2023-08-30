//
//  LessonListDataObject.swift
//  SchoolTimeTable
//
//  Created by student on 2023/06/07.
//

import RealmSwift
import Foundation

class LessonListDataObject: Object {
    
    @Persisted var monday: List<LessonDetailDataObject>
    
    @Persisted var thuesday: List<LessonDetailDataObject>
    
    @Persisted var wednesday: List<LessonDetailDataObject>
    
    @Persisted var thursday: List<LessonDetailDataObject>
    
    @Persisted var friday: List<LessonDetailDataObject>
    
    override init() {}
    
    init(listViewModel: LessonListViewModel) {
        super.init()
        self.monday = translate(viewModels: listViewModel.monday)
        self.thuesday = translate(viewModels: listViewModel.thuesday)
        self.wednesday = translate(viewModels: listViewModel.wednesday)
        self.thursday = translate(viewModels: listViewModel.thursday)
        self.friday = translate(viewModels: listViewModel.friday)
    }
    
    func translate(viewModels: [LessonDetailViewModel]) -> List<LessonDetailDataObject> {
        let list = List<LessonDetailDataObject>()
        for item in viewModels {
            let object = LessonDetailDataObject(viewModel: item)
            list.append(object)
        }
        return list
    }
    
}
