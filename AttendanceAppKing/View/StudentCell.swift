//
//  StudentCell.swift
//  AttendanceAppKing
//
//  Created by marvin evins on 5/8/20.
//  Copyright © 2020 websavantmedia. All rights reserved.
//

import UIKit

class StudentCell: UICollectionViewCell {
    
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var first_name: UILabel!
    
    
    @IBOutlet weak var last_name: UILabel!
    
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var tardies: UILabel!
    
    @IBOutlet weak var absences: UILabel!
    
    var student: Student!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell (student: Student){
        self.student = student
//        var  id: Double? = Double(self.id.text!)
//        id.text = Double(self.student.id)
        
        
        id.text = self.student.id
        first_name.text = self.student.first_name.capitalized
        last_name.text = self.student.last_name.capitalized
        email.text = self.student.email
        
        
        
        
        
        
        
        
    }
}
