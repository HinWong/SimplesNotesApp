//
//  NoteDetailViewController.swift
//  Assesment 1
//
//  Created by Hin Wong on 2/28/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var noteTextField: UITextView!
    
    //MARK:- Properties
    var note: Note?
    
    //MARK:- Life Cycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK:-Actions
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let noteText = noteTextField.text else {return}
        
        if let note = note {
            
            NoteController.sharedInstance.updateNote(note: note, newNoteText: noteText)
        }
        else {
            
            NoteController.sharedInstance.createNote(noteText: noteText)
        }
        navigationController?.popViewController(animated: true)

}

//MARK:- Helper Functions

    func updateViews() {
        
        guard let note = note else {return}
        
        noteTextField.text = note.noteText
        
}
}
