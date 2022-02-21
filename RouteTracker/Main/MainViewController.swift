//
//  MainViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 29.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var router: MainRouter!
    @IBAction func showMap(_ sender: UIButton) {
        router.toMap()
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLogin")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}


class MainRouter: BaseRouter {
    func toMap() {
        perform(segue: "showMap")
    }
}
