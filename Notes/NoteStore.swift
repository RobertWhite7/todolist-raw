//
//  NoteStore.swift
//  Notes
//
//  Created by Robert White on 10/19/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit

class NoteStore {
    static let shared = NoteStore()
    
    fileprivate var notes: [Note]!
    
    var selectedImage: UIImage?
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            notes = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as!
                [Note]
        }else {
            notes = []
            notes.append(Note(title: "Category", text: "Description", dueDate: "Date", dueTime: "Time", complete: "Complete", priority: "Priority"))
            save()
        }
        sort()
    }
    
    
    // MARK: - Public functions
    
    func getNote(_ index: Int) -> Note {
        return notes[index]
    }
    func addNote(_ note: Note) {
        notes.insert(note, at: 0)
    }
    func updateNote(_ note: Note, index: Int) {
        notes[index] = note
    }
    
    func deleteNote(_ index: Int) {
        notes.remove(at: index)
    }
    
    func getCount() -> Int {
        return notes.count
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(notes, toFile: archiveFilePath())
    }
    
    func sort() {
        //   notes.sort { (note1, note2) -> Bool in
        //     return note1.date.compare(note2.date) == .orderedDescending
        // }
        notes.sort {
            $0.date.compare($1.date) == .orderedDescending
        }
        
        
        
    }
    
    // MARK: - Private Functions
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("NoteStore.plist")
        return path
    }
    
}
