//
//  StargazerError.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import Foundation

struct StargazerError: Error, Decodable{
    let message: String?
}
