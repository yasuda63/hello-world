//
//  LessonDetailDataObject.swift
//  SchoolTimeTable
//
//  Created by student on 2023/06/07.
//

import RealmSwift
import UIKit

class LessonDetailDataObject: Object {
    
    @Persisted var lessonId: String
    
    @Persisted var title: String
    
    @Persisted var teacher: String
    
    @Persisted var images: List<LessonDetailImageDataObject>
    
    @Persisted var summary: String
    
    override init() {}
    
    init(viewModel: LessonDetailViewModel) {
        self.lessonId = viewModel.lessonId
        self.title = viewModel.title
        self.teacher = viewModel.teacher
        let imageList = List<LessonDetailImageDataObject>()
        for image in viewModel.images {
            let imageData = LessonDetailImageDataObject(image: image)
            imageList.append(imageData)
        }
        self.images = imageList
        self.summary = viewModel.summary
    }
    
}
