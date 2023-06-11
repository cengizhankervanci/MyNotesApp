//
//  NoteProTests.swift
//  NoteProTests
//
//  Created by Cengizhan Kervancı on 9.06.2023.
//

import XCTest
@testable import NotePro

final class NoteProTests: XCTestCase {

    var mockNoteViewModel : NoteViewModel!
    
    func testNoteCounter(){
        self.mockNoteViewModel = NoteViewModel(noteModel: NoteModel())
        mockNoteViewModel.noteModel.myNotes.append(noteDetails(title: "test", content: "1234"))
        XCTAssertEqual(mockNoteViewModel.noteModel.myNotes.count, 1)
    }
    
    func testAddNotes(){
        self.mockNoteViewModel = NoteViewModel(noteModel: NoteModel())
        mockNoteViewModel.addNotes(title: "test", content: "test123")
        XCTAssertEqual(mockNoteViewModel.noteModel.myNotes[0].title,"test")
        XCTAssertEqual(mockNoteViewModel.noteModel.myNotes[0].content,"test123")
    }
    
    func testUpdateNotes(){
        self.mockNoteViewModel = NoteViewModel(noteModel: NoteModel())
        mockNoteViewModel.addNotes(title: "testTitle", content: "testContent")
        
        mockNoteViewModel.updateNotes(title: "titleTEST", content: "contentTEST", index: 0)
        
        XCTAssertEqual(mockNoteViewModel.noteModel.myNotes[0].title, "titleTEST")
        XCTAssertEqual(mockNoteViewModel.noteModel.myNotes[0].content, "contentTEST")
    }
    
    func testDeleteNotes(){
        var myTest = false
        
        self.mockNoteViewModel = NoteViewModel(noteModel: NoteModel())
        mockNoteViewModel.addNotes(title: "deneme", content: "deneme")
        
        mockNoteViewModel.deleteNote(index: 0)
        
        if mockNoteViewModel.noteModel.myNotes.count == 0 {
            myTest = true
        }
        
        XCTAssertTrue(myTest)
    }

}
