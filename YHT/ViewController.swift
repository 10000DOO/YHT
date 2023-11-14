//
//  ViewController.swift
//  YHT
//
//  Created by 이건준 on 11/14/23.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func startUnity(_ sender: Any) {
        UnityManager.shared.launchUnity()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

