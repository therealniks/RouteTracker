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
    
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        guard let login = loginView.text,
              let password = passwordView.text,
              login == Constants.login && password == Constants.password else {return}
        
        print("LOGIN")
        performSegue(withIdentifier: "onLogin", sender: nil)
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
    @IBAction func recovery(_ sender: UIButton) {
        performSegue(withIdentifier: "onReset", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
