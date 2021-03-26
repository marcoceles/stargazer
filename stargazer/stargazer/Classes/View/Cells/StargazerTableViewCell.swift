//
//  StargazerTableViewCell.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import UIKit

class StargazerTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var avatarImageView: RemoteImageView!

    //MARK: - Properties
    var viewModel: StargazerCellViewModel?{
        didSet{
            updateUI()
        }
    }

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView.cancelLoad()
    }

    override func prepareForReuse() {
        self.viewModel = nil
        self.avatarImageView.url = nil
        self.avatarImageView.cancelLoad()
    }

    //MARK: - UI
    private func updateUI(){
        self.loginLabel.text = viewModel?.login
        self.avatarImageView.url = viewModel?.avatarURL
    }

}
