//
//  LaunchViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 05.12.2021.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isLogin") {
            performSegue(withIdentifier: "onMain", sender: nil)
        } else {
            performSegue(withIdentifier: "onLogin", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
}


class RootSegue: UIStoryboardSegue {
    override func perform() {
        UIApplication.shared.windows.first?.rootViewController = destination
        
    }
    
}
