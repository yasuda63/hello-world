//
//  LessonDetailImageDetaObject.swift
//  SchoolTimeTable
//
//  Created by student on 2023/06/07.
//

import RealmSwift
import UIKit

class LessonDetailImageDataObject: Object {
    
    @Persisted var image: Data
    
    override init() {}
    
    init(image: UIImage) {
        self.image = image.jpegData(compressionQuality: 0.0)!
    }
}
