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
           
           // grab the path of where we are saving or grabbing our data
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           
           // grabbing the first path we got back
           let documentDirectory = paths[0]
           
           // deciding the name of the file that we want
           let filename = "Note.json"
           
           // putting our fill URL together
           let fullURL = documentDirectory.appendingPathComponent(filename)
           
           // returning the full URL
           return fullURL
       }
       
    func saveToPersistence(notes:[Note]) {
           
           // create JSON encoder
           let jsonEncoder = JSONEncoder()
           
           do {
               // try to encode the data
               let data = try jsonEncoder.encode(notes)
               // try to save the data
               try data.write(to: fileURL())
           }
               // catching errors
           catch let error {
               print("\(error.localizedDescription) -> \(error)")
           }
       }
       
       func loadFromPersistence()  {
           
           // create json decoder
           let jsonDecoder = JSONDecoder()
           do {
               // grab data from file path
               let data = try Data(contentsOf: fileURL())
               
               // decoding our data into the type Array of Quote from the data that we just grabbed
               let notes = try jsonDecoder.decode([Note].self, from: data)
               
               // setting our source of truth to quotesDecoded
               self.notes = notes
           }
           catch let error {
               print("\(error.localizedDescription) -> \(error)")
           }
    
       }
    
    
} // end of class
