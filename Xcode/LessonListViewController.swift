//
//  LessonListViewController.swift
//  SchoolTimeTable
//
//  Created by student on 2023/04/26.
//

import UIKit

class LessonListViewController: UIViewController {
    
    @IBOutlet weak var tabelView: UITableViewCell!
    
    let viewmodel: LessonDetailViewModel = .init(
        title: "ListToDetail",
        teacher: "hogehoge",
        images: [],
        summary: "fugafuga")
    
    let listViewModel: LessonListViewModel = .init(
        monday: [LessonListViewController.viewModel],
        thuesday: [LessonListViewController.viewModel],
        wednesday: [LessonListViewController.viewModel],
        thursday: [LessonListViewController.viewModel],
        friday: [LessonListViewController.viewModel])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        tabelView.delegate = self
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "listToDetail":
            let detailview = segue.destination as? LessonDetailViewController
            detailview?.viewModel = sender as? LessonDetailViewModel
            print("ListToDetail")
            default:
        break
        }
    }

}

extension LessonListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return LessonListViewModel.DayOfWeek.allCases.count
    }
    
    func tableView(_ tabelView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dayOfWeek = LessonListViewModel.DayOfWeek(rawValue: section)
        return dayOfWeek?.fetchLabel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dayOfWeek = LessonListViewModel.DayOfWeek(rawValue: section) else {
            return 0
        }
        let count = listViewModel.fetch(item: dayOfWeek).count
        if count == 0 {
            return 1
        } else {
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let dayOfWeek = LessonListViewModel.DayOfWeek(rawValue: indexPath.section) else {
            fatalError()
        }
        let viewModels = listViewModel.fetch(item: dayOfWeek)
        let identifier:  String
        if viewModels.isEmpty {
            identifier = "EmptyCell"
        } else {
            identifier = "LessonCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let lessonCell = cell as? LessonTableViewCell{
            let viewModel = viewModels[indexPath.row]
            lessonCell.configure(title:viewModel.title, teacherName: viewModel.teacher)
        }
        return cell
    }
    
}

extension LessonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        guard let dayOfWeek = LessonListViewModel.DayOfWeek(rawValue: indexPath.section) else {
            return
        }
        let viewModel = listViewModel.fetch(item: dayOfWeek)
        guard viewModels.count.isEmpty else {
            return
        }
        let viewModel = viewModels[indexPath.row]
        performSegue(withIdentifier: "listToDetail", sender: nil)
    }
    
}
