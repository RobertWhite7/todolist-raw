//
//  Note.swift
//  Notes
//
//  Created by Robert White on 10/18/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation
import UIKit

class Note: NSObject, NSCoding {
   
    var title = ""
    var text = ""
    var dueDate = ""
    var dueTime = ""
    var date = Date()
    var image: UIImage?
    var due = Date()
    var complete = ""
    var priority = ""
    var completed = Bool()
    
  
    
   
    
    let titleKey = "title"
    let textKey = "text"
    let dateKey = "date"
    let imageKey = "image"
    var dueDateKey = "dueKey"
    var dueTimeKey = "time"
    var dueKey = "due"
    var completeKey = "complete"
    var priorityKey = "priority"
    var completedKey = "completed"
  
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        return dateFormatter.string(from: due)
    }

    
   override init() {
    super.init()
        
    }
    
    init(title: String, text: String, dueDate: String, dueTime: String, complete: String, priority: String) {
        self.title = title
        self.text = text
        self.dueDate = dueDate
        self.dueTime = dueTime
        self.complete = complete
        self.priority = priority
       
        
      
       
    }
    required init?(coder aDecoder: NSCoder){
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey) as! String
        self.dueTime = aDecoder.decodeObject(forKey: dueTimeKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        self.due = aDecoder.decodeObject(forKey: dueKey) as! Date
        self.complete = aDecoder.decodeObject(forKey: completeKey) as! String
        self.priority = aDecoder.decodeObject(forKey: priorityKey) as! String
        self.completed = aDecoder.decodeObject(forKey: completedKey) as! Bool
     
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
        aCoder.encode(dueTime, forKey: dueTimeKey)
        aCoder.encode(due, forKey: dueKey)
        aCoder.encode(complete, forKey: completeKey)
        aCoder.encode(priority, forKey: priorityKey)
        aCoder.encode(completed, forKey: completedKey)
    }
}

