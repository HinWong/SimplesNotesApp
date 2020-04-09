//
//  NoteController.swift
//  Assesment 1
//
//  Created by Hin Wong on 2/28/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation

class NoteController {
    
    //MARK:- Properties
    
    //source of truth
    var notes: [Note] = []
    
    //shared instance
    static let sharedInstance = NoteController()
    
    init () {
        
        loadFromPersistence()
    }
    
    //MARK:- CRUD functions
    
    func createNote(noteText:String) {
        
        let note = Note(noteText: noteText)
        notes.append(note)
        saveToPersistence(notes: notes)
    }
    
    func deleteNote(note:Note) {
        
        guard let index = notes.firstIndex(of: note) else {return}
        notes.remove(at: index)
        saveToPersistence(notes: notes)
        
    }
    
    func updateNote(note: Note, newNoteText:String) {
        
        note.noteText = newNoteText
        saveToPersistence(notes: notes)
        
    }
    
    //MARK: - Persistence
    
    func fileURL() -> URL {
           
           
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           
           let documentDirectory = paths[0]
           
           let filename = "Note.json"
   
           let fullURL = documentDirectory.appendingPathComponent(filename)

           return fullURL
       }
       
    func saveToPersistence(notes:[Note]) {
           
           // create JSON encoder
           let jsonEncoder = JSONEncoder()
           
           do {
               
               let data = try jsonEncoder.encode(notes)
               
               try data.write(to: fileURL())
           }
               
           catch let error {
               print("\(error.localizedDescription) -> \(error)")
           }
       }
       
       func loadFromPersistence()  {
           
           
           let jsonDecoder = JSONDecoder()
           do {
               
               let data = try Data(contentsOf: fileURL())
               
               let notes = try jsonDecoder.decode([Note].self, from: data)
               
               self.notes = notes
           }
           catch let error {
               print("\(error.localizedDescription) -> \(error)")
           }
    
       }
    
    
} // end of class
