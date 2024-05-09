//
//  ContainerViewController.swift
//  HumaneTime
//
//  Created by Aranza Manriquez Alonso on 08/05/24.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func closeButton(_ sender: UIButton) {

        if let secondVC = parent as? SecondViewController {
            secondVC.toggleMenu()
        }
    }


}
