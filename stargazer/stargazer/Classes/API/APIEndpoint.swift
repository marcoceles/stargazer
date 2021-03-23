//
//  APIEndpoint.swift
//  stargazer
//
//  Created by Marco Celestino on 23/03/2021.
//

import Foundation
import Alamofire

enum APIEndpoint : URLConvertible{

    case getStargazers(owner: String, repo: String)

    // MARK: - Properties
    var method: HTTPMethod {
        switch self {
        case .getStargazers(_, _):
            return .get
        }
    }

    var url: URL? {
        guard let baseUrl = URL.getBaseUrl() else{
            return nil
        }
        switch self {
        case .getStargazers(let owner, let repo):
            return baseUrl.appendingPathComponent("repos/\(owner)/\(repo)/stargazers")
        }
    }

    func asURL() throws -> URL {
        guard let url = self.url else { throw AFError.invalidURL(url: self) }

        return url
    }
}

private extension URL {
    static func getBaseUrl() -> URL? {
        guard let info = Bundle.main.infoDictionary,
              let urlString = info["base_url"] as? String,
              let url = URL(string: urlString) else {
            print("Can't get base url from info.plist")
            return nil
        }

        return url
    }
}

