//
//  APIClient.swift
//  SchoolTimeTable
//
//  Created by student on 2023/07/05.
//

import Foundation
import Network

class  APIClient{
    
    func fetchHoliday(completion: @escaping (Result<HolidaysModel, Error>) -> Void) {
        guard let url = URL(string: "https://masamiyamate.github.io/SchoolTimetable/empty/") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            do{
                let holidaysModel = try JSONDecoder().decode(HolidaysModel.self, from: data)
                completion(.success(holidaysModel))
            } catch {
                completion(.failure(error))
            }
            print("取得完了")
        }
        print("取得開始")
        task.resume()
    }
    
}

