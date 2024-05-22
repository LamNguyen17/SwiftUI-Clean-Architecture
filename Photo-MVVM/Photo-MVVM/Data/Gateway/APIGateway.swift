//
//  APIGateway.swift
//  Photo-MVVM
//
//  Created by Lam Nguyen Tuan on 22/5/24.
//

import Alamofire
import RxSwift

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    var afMethod: Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: self.rawValue)
    }
}

protocol APIGateway {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var mockFile: String { get }
}

extension APIGateway {
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var mockFile: String {
        return ""
    }
    
    func request<T: Decodable>(returnType: T.Type) -> Observable<T> {
            return Observable.create { observer in
                // Check if mock data should be used
//                if let mockData = self.loadMockData(from: request.mockFile) {
//                    do {
//                        let decodedData = try JSONDecoder().decode(T.self, from: mockData)
//                        observer.onNext(decodedData)
//                        observer.onCompleted()
//                    } catch {
//                        observer.onError(error)
//                    }
//                    return Disposables.create()
//                }
                
                // Real network request
                let url = "\(AppConfig.current.baseUrl)/\(path)"
                print(">>> Network Request:", url)
                AF.request(url, method: method.afMethod, headers: headers)
                    .validate()
                    .responseDecodable(of: T.self) { response in
                        switch response.result {
                        case .success(let value):
//                            print(">>> Network Response \(method.rawValue):", value)
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
                return Disposables.create()
            }
        }
}

