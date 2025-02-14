//
//  FetchRecipesUseCaseProtocol.swift
//  Domain
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import RxSwift
import Models

public protocol FetchRecipesUseCaseProtocol {
    func execute() -> Single<[Recipe]>
}
