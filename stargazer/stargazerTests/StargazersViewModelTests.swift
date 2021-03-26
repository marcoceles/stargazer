//
//  StargazersViewModelTests.swift
//  stargazerTests
//
//  Created by Marco Celestino on 26/03/2021.
//

import XCTest
@testable import stargazer

class StargazersViewModelTests: XCTestCase {

    private var stargazersExpectation: XCTestExpectation!
    private var errorExpectation: XCTestExpectation!

    private var results: [Stargazer]?
    private var error: StargazerError?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GetStargazers() {

        stargazersExpectation = expectation(description: "Stargazers")

        let viewModel = StargazersViewModel(with: "rr", repo: "rr", delegate: self)
        viewModel.getStargazers()

        wait(for: [stargazersExpectation], timeout: 10)

        XCTAssert(results != nil && results!.count > 0)
    }

    func test_Error_GetStargazers() {

        errorExpectation = expectation(description: "Error")

        let viewModel = StargazersViewModel(with: "", repo: "", delegate: self)
        viewModel.getStargazers()

        wait(for: [errorExpectation], timeout: 10)

        XCTAssertNotNil(error)
    }
}

extension StargazersViewModelTests: StargazersDataSourceDelegate{
    func didLoad(items: [Stargazer]) {
        results = items
        stargazersExpectation.fulfill()
    }

    func didFail(with error: StargazerError) {
        self.error = error
        errorExpectation.fulfill()
    }
}
