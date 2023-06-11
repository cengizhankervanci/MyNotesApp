//
//  NoteProtocols.swift
//  NotePro
//
//  Created by Cengizhan Kervancı on 9.06.2023.
//

import Foundation

protocol NoteProtocols{
    
    func addNotes(title : String , content : String)
    
    func updateNotes(title : String , content : String, index : Int)
    
    func deleteNote(index : Int)
}
