//
//  ViewController.swift
//  Task
//
//  Created by Валентин Ломов on 09.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var observableLogin = BehaviorRelay(value: "")
    var observablePassword = BehaviorRelay(value: "")
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        rxSetup()
    }
    
    // MARK: Setup all rx
    func rxSetup() {
        loginTextfield.rx.text
            .orEmpty
            .bind(to: observableLogin)
            .disposed(by: disposeBag)

        passwordTextfield.rx.text
            .orEmpty
            .bind(to: observablePassword)
            .disposed(by: disposeBag)
        
        
        let isValid = Observable.combineLatest(
                observableLogin.asObservable(),
                observablePassword.asObservable()
            ){ (login, password) in
                return login.count > 0 && password.count > 0
            }
        
        _ = isValid.asObservable().subscribe { (newValue) in
            let buttonEnable = newValue.element ?? false
            self.signInButton.isEnabled = buttonEnable
        }
        
        signInButton.rx.tap
            .subscribe(onNext: {
                let user = User(login: self.loginTextfield.text!, password: self.passwordTextfield.text!)
                if !user.validation() {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = user.error
                } else {
                    self.errorLabel.isHidden = true
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "AuthOK", sender: self)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

