//
//  MockFetchRecipesUseCase.swift
//  Domain
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import RxSwift
import UseCases
import Models
import Networking
import Foundation

public class MockFetchRecipesUseCase: FetchRecipesUseCaseProtocol {
    
    public var fetchRecipesResult: Single<[Recipe]>?
    
    public init() {}
    
    public func execute() -> Single<[Recipe]> {
        return fetchRecipesResult ?? Single.error(
            NSError(
                domain: "MockFetchRecipesUseCase",
                code: -1,
                userInfo: nil
            )
        )
    }
}
