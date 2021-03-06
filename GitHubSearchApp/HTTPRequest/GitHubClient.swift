//
//  GitHubClient.swift
//  GitHubSearchRepository
//
//  Created by Hachibe on 2017/03/04.
//  Copyright © 2017年 Masanori. All rights reserved.
//

import Foundation
import UIKit

class GitHubClient {
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    var dataTask: URLSessionDataTask?
    
    func send<Request: GitHubRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
        let urlRequest = request.buildURLRequest()
        dataTask = session.dataTask(with: urlRequest) { data, response, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch (data, response, error) {
            case (_, _, let error?):
                if error._code == NSURLErrorCancelled {
                    completion(Result(error: .cancel))
                } else {
                    completion(Result(error: .connectionError(error)))
                }
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(Result(value: response))
                } catch let error as GitHubAPIError {
                    completion(Result(error: .apiError(error)))
                } catch {
                    completion(Result(error: .responseParseError(error)))
                }
            default:
                fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error)).")
            }
        }
        dataTask!.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func cancel() {
        if let task = dataTask {
            task.cancel()
        }
    }
}
