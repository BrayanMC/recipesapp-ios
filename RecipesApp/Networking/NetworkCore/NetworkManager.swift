//
//  NetworkManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Alamofire
import RxSwift
import Foundation

class NetworkManager {
    
    private let session: Session
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 40
        configuration.timeoutIntervalForRequest = 40
        session = Session(configuration: configuration)
    }
    
    func request<T: Decodable>(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) -> Single<T> {
        return Single<T>.create { single in
            guard NetworkMonitor.shared.isConnected else {
                single(.failure(APIError(
                    message: ErrorMessage.NetworkConnectionError.rawValue,
                    error: ErrorTitle.NetworkConnectionError.rawValue,
                    code: ErrorCode.NetworkError.rawValue
                )))
                return Disposables.create {}
            }
            
            let request = self.session.request(
                url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            ).validate().responseDecodable(of: T.self) { response in
                debugPrint("URL ---->", url)
                debugPrint("response: ", response)
                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure:
                    if let data = response.data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        single(.failure(APIError(
                            message: errorResponse.message ?? ErrorMessage.DefaultError.rawValue,
                            error: errorResponse.title ?? ErrorTitle.DefaultError.rawValue,
                            code: errorResponse.code ?? ErrorCode.GenericError.rawValue
                        )))
                    } else {
                        single(.failure(APIError(
                            message: ErrorMessage.DefaultError.rawValue,
                            error: ErrorTitle.DefaultError.rawValue,
                            code: ErrorCode.GenericError.rawValue
                        )))
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
