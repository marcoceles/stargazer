//
//  StargazersDataSource.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import UIKit

enum Section{
    case main
}

class StargazersDataSource{

    // MARK: - Value Types
    typealias DataSource = UITableViewDiffableDataSource<Section, Stargazer>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Stargazer>

    // MARK: - Properties
    private var tableView: UITableView
    private var dataSource: DataSource!
    private var snapshot = Snapshot()

    var count: Int = 0

    init(with tableView: UITableView) {
        self.tableView = tableView
        makeDataSource()
    }

    private func makeDataSource() {

        snapshot.appendSections([.main])
        
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, stargazer) ->
                UITableViewCell? in

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "stargazerCell",
                    for: indexPath) as? StargazerTableViewCell
                cell?.viewModel = StargazerCellViewModel(with: stargazer)
                return cell
            })
        self.dataSource = dataSource
    }

    func applySnapshot(items: [Stargazer], animatingDifferences: Bool = true) {
        snapshot.appendItems(items)
        count += items.count
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func reset(){
        snapshot.deleteAllItems()
        count = 0
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
