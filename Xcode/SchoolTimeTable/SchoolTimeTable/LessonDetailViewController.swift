//
//  ViewController.swift
//  SchoolTimeTable
//
//  Created by student on 2023/04/25.
//

import UIKit

class LessonDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    
    @IBOutlet weak var lessonImage1: UIImageView!
    
    @IBOutlet weak var lessonImage2: UIImageView!
    
    @IBOutlet weak var lessonImage3: UIImageView!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    var viewModel: LessonDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else{
            return
        }
        configure(model: viewModel)
       // configure(model: .init(title: "hoge", teacher: "fuga", images: [], summary: "summary"))
        //configure(title: "hoge", teacher: "fuga", images: [], summary: "概要", nextDate: Date)
    }
    
    func configure(model: LessonDetailViewModel) {
            titleLabel.text = model.title
            teacherLabel.text = model.teacher
            summaryTextView.text = model.summary
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(didTapedTrashButton(_:)))
        navigationItem.setRightBarButton(barButtonItem, animated: true)
        
            for i in 0..<model.images.count {
            switch i {
            case 0:
                lessonImage1.image = model.images[0]
            case 1:
                lessonImage2.image = model.images[1]
            case 2:
                lessonImage3.image = model.images[2]
            default:
                break
            }
        }
    }
    
    @objc func didTapedTrashButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "授業を削除しますか？", message: "表示中の授業を削除してもいいですか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let viewModel = self.viewModel else {
                return
            }
            TimeTableDataStore.shared.remove(item: viewModel)
            self.navigationController?.popViewController(animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

