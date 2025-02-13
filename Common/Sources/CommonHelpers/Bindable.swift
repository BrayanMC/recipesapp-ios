//
//  Bindable.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

public class Bindable<T> {
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value)
    }
}
