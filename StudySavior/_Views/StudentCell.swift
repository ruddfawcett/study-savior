//
//  StudentCell.swift
//  StudySavior
//
//  Created by Ally Klionsky on 5/2/19.
//  Copyright © 2019 Ally Klionsky. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var course1: CourseTag?
    @IBOutlet weak var course2: CourseTag?
    @IBOutlet weak var course3: CourseTag?
    @IBOutlet weak var course4: CourseTag?
    @IBOutlet weak var course5: CourseTag?
    @IBOutlet weak var course6: CourseTag?

    var student: Student? {
        didSet {
            drawLabels()
            drawTags()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: self.separatorInset.top, left: 0, bottom: self.separatorInset.bottom, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func drawLabels() {
        if let student = student {
            self.nameLabel.text = student.name
            self.majorLabel.text = student.major
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        drawTags()
    }
    
    func drawTags() {
        var courseTags = [course1, course2, course3, course4, course5, course6]
        
        for tag in courseTags {
            tag?.alpha = 1
        }
        
        if let student = student {
            for (i, course) in student.classes.enumerated() {
                if let tag = courseTags[i] {
                    tag.text = course
                }
            }
            courseTags.removeFirst(student.classes.count)
            
            for tag in courseTags {
                if let tag = tag {
                    tag.alpha = 0
                }
            }
        }
    }
}
