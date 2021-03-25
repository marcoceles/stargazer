//
//  StargazersDataSourceDelegate.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import Foundation

protocol StargazersDataSourceDelegate {
    func didUpdateDataSource()
    func didFail(with error: Error)
}
