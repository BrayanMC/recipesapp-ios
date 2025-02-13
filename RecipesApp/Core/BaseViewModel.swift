//
//  BaseViewModel.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import CommonHelpers

class BaseViewModel {
    private(set) var loading: Bindable<Bool> = Bindable(false)
    private(set) var error: Bindable<String?> = Bindable(nil)
    
    public let disposeBag = DisposeBag()
}
