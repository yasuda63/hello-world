//
//  LessonTableViewCell.swift
//  SchoolTimeTable
//
//  Created by student on 2023/05/09.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teacherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, teacherName: String){
        titleLabel.text = title
        teacherLabel.text = teacherName
    }

}
