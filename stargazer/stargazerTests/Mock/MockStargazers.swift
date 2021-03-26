//
//  MockStargazers.swift
//  stargazerTests
//
//  Created by Marco Celestino on 26/03/2021.
//

import Foundation

class MockStargazers{
    let stargazers: [Stargazer]

    init() {
        self.stargazers = Bundle(for: MockStargazers.self)
            .decode([Stargazer].self, from: "stargazers.json")
    }
}
