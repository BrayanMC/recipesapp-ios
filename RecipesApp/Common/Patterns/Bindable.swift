//
//  Bindable.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

class Bindable<T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value)
    }
}
