//
//  NoteViewModel.swift
//  NotePro
//
//  Created by Cengizhan Kervancı on 9.06.2023.
//

import Foundation

class NoteViewModel : NoteProtocols{
    
    var noteModel : NoteModel
    
    init(noteModel: NoteModel) {
        self.noteModel = noteModel
    }
    
    func noteCounter()->Int{
        noteModel.myNotes.count
    }
    
    func matchDatas(index : Int)->detailNote{
        let detail = self.noteModel.myNotes[index]
        return detailNote(detail: detail)
    }
    
    func addNotes(title: String, content: String) {
        self.noteModel.myNotes.append(noteDetails(title: title, content: content))
    }
    
    func updateNotes(title: String, content: String, index: Int) {
        self.noteModel.myNotes[index].title = title
        self.noteModel.myNotes[index].content = content
    }
    
    func deleteNote(index: Int) {
        self.noteModel.myNotes.remove(at: index)
    }
    
}

struct detailNote{
    var detail : noteDetails
    
    var title : String{
        return detail.title
    }
    var content : String{
        return detail.content
    }
}
