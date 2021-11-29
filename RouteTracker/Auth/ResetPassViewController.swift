//
//  ResetPassViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 29.11.2021.
//

import UIKit

class ResetPassViewController: UIViewController {

    @IBOutlet weak var loginView: UITextField!
    
    @IBAction func recovery(_ sender: UIButton) {
        guard let login = loginView.text,
              login == AuthViewController.Constants.login
        else{
            return
        }
        showPassword()
    }
    
    private func showPassword() {
        
        let alertVC = UIAlertController(title: "PASSWORD",
                                        message: "root",
                                        preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(okButton)
        present(alertVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
