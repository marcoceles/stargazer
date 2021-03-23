//
//  APIClient.swift
//  stargazer
//
//  Created by Marco Celestino on 23/03/2021.
//

import Foundation
import Alamofire

class APIClient{

    public static let shared = APIClient()

    private init(){}

    func makeAPICall<O : Decodable>(_ endpoint: APIEndpoint, responseClass: O.Type, completion: @escaping (Result<O, AFError>) -> Void) -> Void {
        let request = AF.request(endpoint, method: endpoint.method).validate(statusCode: 200..<300)
        request.responseDecodable { (response) in
            completion(response.result)
        }
    }
}

extension APIClient{

    public func getStargazers(for owner: String, and repo: String, completion: @escaping (Result<[Stargazer], Error>) -> Void){
        self.makeAPICall(.getStargazers(owner: owner, repo: repo), responseClass: [Stargazer].self, completion: { result in

            switch result{
            case .success(let stargazers):
                completion(.success(stargazers))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
