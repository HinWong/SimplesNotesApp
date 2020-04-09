//
//  Note.swift
//  Assesment 1
//
//  Created by Hin Wong on 2/28/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation

class Note:Codable {
    
    var noteText:String
    
    init(noteText:String) {
        self.noteText = noteText
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.noteText == rhs.noteText
    }
    
}
