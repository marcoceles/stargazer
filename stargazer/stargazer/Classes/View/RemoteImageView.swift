//
//  RemoteImageView.swift
//  stargazer
//
//  Created by Marco Celestino on 25/03/2021.
//

import UIKit

class RemoteImageView : UIImageView{

    var url: URL?{
        didSet{
            loadImage(for: url)
        }
    }

    let queue = OperationQueue()

    private let placeHolderImage = UIImage(systemName: "person.circle")

    func cancelLoad(){
        queue.cancelAllOperations()
    }
    
    func loadImage(for url: URL?){

        guard let url = url else{
            self.image = placeHolderImage
            return
        }

        let activityIndicator = UIActivityIndicatorView(style: .medium)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        activityIndicator.color = .secondaryLabel
        activityIndicator.center = center
        activityIndicator.startAnimating()
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let downloader = DownloadImageOperation(with: url)
        downloader.completionBlock = {
            DispatchQueue.main.async { 

                activityIndicator.stopAnimating()

                guard downloader.error == nil else{
                    self.contentMode = .scaleAspectFit
                    self.image = self.placeHolderImage
                    return
                }
                self.contentMode = .scaleAspectFill
                if let image = downloader.imageDownloaded{
                    self.image = image
                }else{
                    self.image = self.placeHolderImage
                }
            }
        }
        queue.addOperation(downloader)
    }
}
