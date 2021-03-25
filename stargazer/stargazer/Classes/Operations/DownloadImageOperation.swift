//
//  DownloadImageOperation.swift
//  stargazer
//
//  Created by Marco Celestino on 23/03/2021.
//

import UIKit
import Alamofire

class DownloadImageOperation: Operation {

    private var url: URL?
    private var isCompleted: Bool = false
    private var isPerforming: Bool = false
    var imageDownloaded : UIImage? = nil
    var error: AFError? = nil

    init(with url: URL) {
        super.init()
        self.url = url
    }

    override var isFinished: Bool{
        get {
            return isCompleted
        }
        set {
            self.willChangeValue(for: \.isFinished)
            isCompleted = newValue
            self.didChangeValue(for: \.isFinished)
        }
    }

    override var isExecuting: Bool{
        get {
            return isPerforming
        }
        set {
            self.willChangeValue(for: \.isExecuting)
            isPerforming = newValue
            self.didChangeValue(for: \.isExecuting)
        }
    }
    
    override func start() {
        guard !self.isCancelled, let url = url else {
            return
        }

        self.isExecuting = true

        if let cachedImage = ImageCache.shared.image(for: url.absoluteString){
            self.imageDownloaded = cachedImage
            self.cancel()
            return
        }

        AF.download(url).responseData { [weak self] response in

            switch response.result{
            case .success(let data):
                let image = UIImage(data: data)
                self?.imageDownloaded = image
                ImageCache.shared.cache(image: image, for: url.absoluteString)

            case .failure(let error):
                self?.error = error
            }

            self?.isExecuting = false
            self?.isFinished = true
        }
    }

    override func cancel(){
        super.cancel()

        if self.isExecuting{
            self.isFinished = true
        }
    }
}
