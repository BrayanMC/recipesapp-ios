//
//  DIContainer.swift
//  DIContainer
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

public class DIContainer: DIContainerProtocol {
    
    private var services: [String: Any] = [:]

    public init() {}

    public func register<T>(type: T.Type, service: T) {
        let key = String(describing: type)
        services[key] = service
    }

    public func resolve<T>(type: T.Type) -> T? {
        let key = String(describing: type)
        return services[key] as? T
    }
}
