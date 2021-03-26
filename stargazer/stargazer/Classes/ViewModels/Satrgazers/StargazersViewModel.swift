//
//  StargazersViewModel.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import Foundation

class StargazersViewModel {

    var delegate: StargazersDataSourceDelegate

    private var currentPage = 1
    private var theresNoMoreData = false

    var stargazers = [Stargazer]()

    private var owner: String
    private var repo: String

    // MARK: - Init
    init(with owner: String, repo: String, delegate: StargazersDataSourceDelegate) {
        self.owner = owner
        self.repo = repo
        self.delegate = delegate
    }

    // MARK: - API
    func getStargazers(){

        APIClient.shared.getStargazers(for: self.owner,
                                       and: self.repo,
                                       page: self.currentPage)
        { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    guard let response = response, response.count > 0 else{
                        self?.theresNoMoreData = true
                        self?.delegate.didLoad(items: [])
                        return
                    }
                    self?.stargazers.append(contentsOf: response)
                    self?.delegate.didLoad(items: response)
                case .failure(let error):
                    self?.delegate.didFail(with: error)
                }
            }
        }
    }

    func loadMoreData(){
        if !theresNoMoreData{
            self.currentPage += 1
            getStargazers()
        }
    }
}
