//
//  StargazersViewController.swift
//  stargazer
//
//  Created by Marco Celestino on 23/03/2021.
//

import UIKit

class StargazersViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var ownerField: UITextField!{
        didSet{
            ownerField.placeholder = NSLocalizedString("field.placeholder.owner",
                                                       comment: "Owner field placeholder text")
        }
    }
    @IBOutlet weak var repoField: UITextField!{
        didSet{
            repoField.placeholder = NSLocalizedString("field.placeholder.repo",
                                                       comment: "Repository field placeholder text")
        }
    }
    @IBOutlet weak var searchButton: UIButton!{
        didSet{
            searchButton.setTitle(NSLocalizedString("button.title.submit",
                                                    comment: "Submit button title"),
                                                    for: .normal)
        }
    }
    @IBOutlet weak var resultTableView: UITableView!

    // MARK: - Properties
    var viewModel: StargazersViewModel?
    var dataSource: StargazersDataSource?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("stargazers.page.title", comment: "Stargazers page title")

        self.dataSource = StargazersDataSource(with: resultTableView)

        //Prepare tableView
        resultTableView.tableFooterView = UIView()
        resultTableView.prefetchDataSource = self
    }

    // MARK: - Actions
    @IBAction func searchAction(_ sender: Any) {
        guard let owner = ownerField.text, !owner.isEmpty,
              let repo = repoField.text, !repo.isEmpty
        else { return }
        self.dataSource?.reset()
        self.viewModel = StargazersViewModel(with: owner, repo: repo, delegate: self)
        self.viewModel?.getStargazers()
    }
}

//MARK: - PrefetchDelegate
extension StargazersViewController: UITableViewDataSourcePrefetching{

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let items = viewModel?.stargazers else {return}

        if indexPaths.contains(where: {$0.row >= items.count - 1}){
            self.viewModel?.loadMoreData()
        }
    }
}

//MARK: - StargazersDataSourceDelegate
extension StargazersViewController: StargazersDataSourceDelegate {

    func didLoad(items: [Stargazer]) {
        self.dataSource?.applySnapshot(items: items)
    }

    func didFail(with error: StargazerError) {
        self.show(error: error)
    }
}
