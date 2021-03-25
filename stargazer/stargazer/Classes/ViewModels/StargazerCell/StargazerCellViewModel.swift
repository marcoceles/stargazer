//
//  StargazerCellViewModel.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import Foundation

class StargazerCellViewModel {

    private var stargazer: Stargazer

    init(with stargazer: Stargazer) {
        self.stargazer = stargazer
    }

    var login: String {
        self.stargazer.login
    }

    var avatarURL: URL? {
        self.stargazer.avatarURL
    }
}
