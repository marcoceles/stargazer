//
//  StargazerCellViewModelTests.swift
//  stargazerTests
//
//  Created by Marco Celestino on 26/03/2021.
//

import XCTest

class StargazerCellViewModelTests: XCTestCase {

    private let stargazers = MockStargazers().stargazers

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Login() {
        let viewModel = StargazerCellViewModel(with: stargazers.first!)
        XCTAssertEqual(viewModel.login, "ndbroadbent")
    }

    func test_AvatarUrl() {
        let viewModel = StargazerCellViewModel(with: stargazers.first!)
        XCTAssertNotNil(viewModel.avatarURL)
    }
}
