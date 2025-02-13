//
//  DIContainer.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

public final class DIContainer {
    
    private var modules: [String: Any] = [:]
    
    public init() {}
    
    public func register<T>(type: T.Type, service:T) {
        let key = String(describing: type)
        modules[key] = service
    }
    
    public func resolve<T>(type: T.Type) -> T? {
        let key = String(describing: type)
        return modules[key] as? T
    }
}
