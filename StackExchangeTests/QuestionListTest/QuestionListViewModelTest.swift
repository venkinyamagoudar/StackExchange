//
//  QuestionListViewModelTest.swift
//  StackExchangeTests
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import XCTest
@testable import StackExchange

final class QuestionListViewModelTest: XCTestCase {
    
    var viewModel: QuestionsListViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = QuestionsListViewModel(dataManger: MockDataManager())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func test_questionListFetch_valid_result() {
        
        viewModel?.dataManger.getQuestionList(from: "", completion: { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(2, data.items.count)
            case .failure(_):
                fatalError("Error while fetching Question List")
            }
            
        })
    }

}
