//
//  NoteListTableViewController.swift
//  Assesment 1
//
//  Created by Hin Wong on 2/28/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {
    
    
    @IBOutlet var notesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return NoteController.sharedInstance.notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = NoteController.sharedInstance.notes[indexPath.row]
        cell.textLabel?.text = note.noteText
        
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //Find what note the user is trying to delete
            let noteToDelete = NoteController.sharedInstance.notes[indexPath.row]
            
            //Delete it
            NoteController.sharedInstance.deleteNote(note: noteToDelete)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // IIDOO
        
        if segue.identifier == "toNoteDetailView" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                
                let destinationVC = segue.destination as? NoteDetailViewController else {return}
            
            let noteToSend = NoteController.sharedInstance.notes[indexPath.row]
            
            destinationVC.note = noteToSend
        }
    }
}




