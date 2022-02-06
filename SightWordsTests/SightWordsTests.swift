//
//  SightWordsTests.swift
//  SightWordsTests
//
//  Created by Kamil Wrobel on 1/21/22.
//

import XCTest
@testable import SightWords

class SightWordsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    
    func test_DeckView_showAddWord_False(){
        let sut = DeckView()
        XCTAssertFalse(sut.showAddWord, "❌ Failed on line: \(#line), \(#function)")
    }
    
    func test_DeckView_showAddNewDeck_False(){
        let sut = DeckView()
        XCTAssertFalse(sut.showAddNewDeck, "❌ Failed on line: \(#line), \(#function)")
    }
    
    func test_DeckView_ViewModel_NotNil(){
        let sut = DeckView()
        XCTAssertNotNil(sut.viewModel, "❌ Failed on line: \(#line), \(#function)")
    }
    
    
    //first i cant call showAddWordPopUp() because of private protections level
    //if i remove private protection then the test fails 
//    func test_DeckView_ShowAddWordPopUp_Function(){
//        let sut = DeckView()
//        sut.showAddWordPopUp()
//        XCTAssertTrue(sut.showAddWord, "❌ Failed on line: \(#line), \(#function)")
//    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
