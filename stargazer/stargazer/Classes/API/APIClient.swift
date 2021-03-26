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

    func makeAPICall<O : Decodable>(_ endpoint: APIEndpoint, responseClass: O.Type, completion: @escaping (Result<O, StargazerError>) -> Void) -> Void {
        let request = AF.request(endpoint, method: endpoint.method).validate(statusCode: 200..<300)
        request.responseDecodable { (response) in
            completion(response.result.mapError({ (error) -> StargazerError in
                self.decode(errorResponse: response)
            }))
        }
    }

    private func decode<O : Decodable>(errorResponse: DataResponse<O, AFError>) -> StargazerError{
        guard let data = errorResponse.data else {
            return  StargazerError.init(message: errorResponse.error?.localizedDescription)
        }
        let decoder = JSONDecoder()
        do{
            let apiError = try decoder.decode(StargazerError.self, from: data)
            return apiError
        }
        catch{
            return StargazerError.init(message: errorResponse.error?.localizedDescription)
        }
    }
}

extension APIClient{

    public func getStargazers(for owner: String,
                              and repo: String,
                              page: Int,
                              completion: @escaping (Result<StargazersResponse, StargazerError>) -> Void){

        self.makeAPICall(.getStargazers(owner: owner, repo: repo, page: page),
                         responseClass: StargazersResponse.self, completion: { result in

            switch result{
            case .success(let stargazers):
                completion(.success(stargazers))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
