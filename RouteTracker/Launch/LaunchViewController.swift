//
//  LaunchViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 05.12.2021.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var router: LaunchRouter!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isLogin") {
            router.toMain()
        } else {
            router.toAuth()
        }
        // Do any additional setup after loading the view.
    }
}

class LaunchRouter: BaseRouter {
    func toMain() {
        perform(segue: "onMain")
    }
    func toAuth() {
        perform(segue: "onLogin")
    }
}


class RootSegue: UIStoryboardSegue {
    override func perform() {
        UIApplication.shared.windows.first?.rootViewController = destination
        
    }
    
}
