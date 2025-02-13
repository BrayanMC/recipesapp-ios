//
//  BaseViewModel.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import CommonHelpers

open class BaseViewModel {
     
    public private(set) var loading: Bindable<Bool> = Bindable(false)
    public private(set) var error: Bindable<String?> = Bindable(nil)
    
    public let disposeBag = DisposeBag()
    
    public init() {
        // empty
    }
}
