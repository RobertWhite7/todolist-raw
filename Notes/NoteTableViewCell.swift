//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Robert White on 10/18/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTableLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var dueTimeLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
   
    
 
   
    
    
    
    weak var note: Note!
    
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell(_ note: Note) {
       
        self.note = note
        noteTableLabel.text = note.title
        noteTextLabel.text = note.text
        noteDateLabel.text = note.dateString
        dueTimeLabel.text = note.dueTime
        dueDateLabel.text = note.dueDate
        completeLabel.text = note.complete
        priorityLabel.text = note.priority
        
      
        
        
      
    }

}
