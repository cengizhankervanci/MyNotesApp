//
//  NoteProUITests.swift
//  NoteProUITests
//
//  Created by Cengizhan Kervancı on 9.06.2023.
//

import XCTest

final class NoteProUITests: XCTestCase {

    func testAddedNote(){
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.navigationBars["NotePro.View"].buttons["add"]

        let elementsQuery = app.alerts["Add Notes"].scrollViews.otherElements
        let collectionViewsQuery = elementsQuery.collectionViews
        let titleTF = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Please Enter Title"]/*[[".cells.textFields[\"Please Enter Title\"]",".textFields[\"Please Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let pleaseEnterContentTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Please Enter Content"]/*[[".cells.textFields[\"Please Enter Content\"]",".textFields[\"Please Enter Content\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let enterButton = elementsQuery.buttons["Enter"]

        let myCell = app.tables.cells.containing(.staticText, identifier: "TestTitle").element
        
        addButton.tap()
        titleTF.tap()
        titleTF.typeText("TestTitle")
        pleaseEnterContentTextField.tap()
        pleaseEnterContentTextField.typeText("TestContent")
        enterButton.tap()
        
        XCTAssertTrue(myCell.exists)
    }
    
    func testDeleteNote(){
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.navigationBars["NotePro.View"].buttons["add"]

        let elementsQuery = app.alerts["Add Notes"].scrollViews.otherElements
        let collectionViewsQuery = elementsQuery.collectionViews
        let titleTF = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Please Enter Title"]/*[[".cells.textFields[\"Please Enter Title\"]",".textFields[\"Please Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let pleaseEnterContentTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Please Enter Content"]/*[[".cells.textFields[\"Please Enter Content\"]",".textFields[\"Please Enter Content\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let enterButton = elementsQuery.buttons["Enter"]

        let myCell = app.tables.cells.containing(.staticText, identifier: "TestTitle").element
        
        let tablesQuery = app.tables
        let deleteButton = tablesQuery.buttons["Delete"]
        
        addButton.tap()
        titleTF.tap()
        titleTF.typeText("TestTitle")
        pleaseEnterContentTextField.tap()
        pleaseEnterContentTextField.typeText("TestContent")
        enterButton.tap()
        
        myCell.swipeLeft()
        deleteButton.tap()
        
        XCTAssertFalse(myCell.exists)
        
    }
    
    func testEditNote(){
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.navigationBars["NotePro.View"].buttons["add"]

        let elementsQuery = app.alerts["Add Notes"].scrollViews.otherElements
        let collectionViewsQuery = elementsQuery.collectionViews
        let titleTF = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Please Enter Title"]/*[[".cells.textFields[\"Please Enter Title\"]",".textFields[\"Please Enter Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let pleaseEnterContentTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Please Enter Content"]/*[[".cells.textFields[\"Please Enter Content\"]",".textFields[\"Please Enter Content\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        let enterButton = elementsQuery.buttons["Enter"]

        let myCell = app.tables.cells.containing(.staticText, identifier: "TestTitle").element
        
        let tablesQuery = app.tables
        let editButton = tablesQuery.buttons["Edit"]
        
        addButton.tap()
        titleTF.tap()
        titleTF.typeText("TestTitle")
        pleaseEnterContentTextField.tap()
        pleaseEnterContentTextField.typeText("TestContent")
        enterButton.tap()
        
        myCell.swipeLeft()
        editButton.tap()
        
        let elementsQuery2 = app.alerts["Edit"].scrollViews.otherElements
        
        let collectionViewsQuery2 = elementsQuery2.collectionViews
        let titleTF2 = collectionViewsQuery2.textFields["TestTitle"]
        
        let pleaseEnterContentTextField2 = collectionViewsQuery2.textFields["TestContent"]
        
        let editButton2 = elementsQuery2.buttons["Edit"]
        
        titleTF2.tap()
        titleTF2.typeText("Edited Title")
        
        pleaseEnterContentTextField2.tap()
        pleaseEnterContentTextField2.typeText("Edited Content")
        
        editButton2.tap()
        
        let myCellNew = app.tables.cells.containing(.staticText, identifier: "TestTitleEdited Title").element
        
        XCTAssertTrue(myCellNew.exists)
    }
}
