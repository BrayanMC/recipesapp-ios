//
//  DIContainerProtocol.swift
//  DIContainer
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

public protocol DIContainerProtocol {
    func resolve<T>(type: T.Type) -> T?
}
