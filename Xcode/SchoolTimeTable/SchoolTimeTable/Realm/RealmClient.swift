//
//  RealmClient.swift
//  SchoolTimeTable
//
//  Created by student on 2023/06/07.
//

import RealmSwift
import Foundation

class RealmClient{
    
    let realm: Realm
    
    init() {
        do {
            realm = try! Realm()
        } catch {
            var config = Realm.Configuration()
            config.deleteRealmIfMigrationNeeded = true
            realm = try! Realm(configuration: config)
        }
    }
    
    func fetchListData() -> LessonListDataObject? {
        let results = realm.objects(LessonListDataObject.self)
        return results.first
    }
    
    func saveListData(dataObject: LessonListDataObject) {
        try! realm.write({
            let results = realm.objects(LessonListDataObject.self)
            realm.delete(results)
            realm.add(dataObject)
        })
    }
    
}
