//
//  MainViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 29.11.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func showMap(_ sender: UIButton) {
        performSegue(withIdentifier: "showMap", sender: nil)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLogin")
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
