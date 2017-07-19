//
//  LoginViewModel.swift
//  Alemua
//
//  Created by Cong Nguyen on 7/19/17.
//  Copyright © 2017 cong. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    //Input
    var username = Variable("")
    var password = Variable("")
    var btnSignin = Variable<Void>()
    var btnSignup = Variable<Void>()
    //Output
    //example: is enable signin button, we use driver of observalbe. Driver is observable with relay = 1, and retry = 3?? i'm not sure.
    var enableSignin: Driver<Bool>
    var signinSuccess = PublishSubject<Bool>()
    
//    let userRepo = UserRepository()
    
    //RX
    var bag = DisposeBag()
//    var delegate: LoginCoordinatorDelegate!
    init() {
        //Observable<Bool>
        enableSignin = Observable.combineLatest(username.asObservable(), password.asObservable()) { (user, pass) -> Bool in
            return user.characters.count > 0 && pass.characters.count > 0
            }.asDriver(onErrorJustReturn: false)
        
        //handle tab signin
        btnSignin.asObservable().skip(1).subscribe(onNext: {
//            let model = UserModel()
//            model.email = self.username.value
//            model.password = self.password.value
//            if self.userRepo.checkValid(model) {
//                self.signinSuccess.onNext(true)
//            } else {
//                self.signinSuccess.onNext(false)
//            }
        }).addDisposableTo(bag)
//        btnSignup.asObservable().skip(1).subscribe(onNext: { self.delegate.showSignup() }).addDisposableTo(bag)
    }
    
}
