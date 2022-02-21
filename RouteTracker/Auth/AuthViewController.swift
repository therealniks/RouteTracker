//
//  AuthViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 29.11.2021.
//

import UIKit

class AuthViewController: UIViewController {

    enum Constants {
        static let login = "admin"
        static let password = "root"
    }
    @IBOutlet weak var router: LoginRouter!
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        guard let login = loginView.text,
              let password = passwordView.text,
              login == Constants.login && password == Constants.password else {return}
        
        print("LOGIN")
        router.toMain()
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
    @IBAction func recovery(_ sender: UIButton) {
        router.onReset()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

}

class LoginRouter: BaseRouter {
    func toMain() {
        perform(segue: "onLogin")
    }
    func onReset() {
        perform(segue: "onReset")
    }
}
