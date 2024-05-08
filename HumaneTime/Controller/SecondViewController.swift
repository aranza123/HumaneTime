//
//  SecondViewController.swift
//  HumaneTime
//
//  Created by Aranza Manriquez Alonso on 06/05/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    
    var isMenuOpen = false
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gesto de deslizamiento
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                view.addGestureRecognizer(panGesture)
    }
  
    @IBAction func menuTapped(_ sender: UIButton) {
        toggleMenu()
    }
    
    //Para manejar el gesto de deslizamiento
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
            let translation = recognizer.translation(in: view)
            
            switch recognizer.state {
            case .changed:
                let newConstant = menuLeadingConstraint.constant + translation.x
                if newConstant >= -320 && newConstant <= 0 {
                    menuLeadingConstraint.constant = newConstant
                }
                recognizer.setTranslation(.zero, in: view)
            case .ended:
                    //Para cerrar deslizando
                if menuLeadingConstraint.constant < -160 {
                    hideMenu()
                } else {
                    showMenu()
                }
            default:
                break
            }
        }
    
        //Para abrir y cerrar menu
        func toggleMenu() {
            if menuLeadingConstraint.constant == 0 {
                hideMenu()
            } else {
                showMenu()
            }
        }
        
        func hideMenu() {
            UIView.animate(withDuration: 0.3) {
                self.menuLeadingConstraint.constant = -320
                self.view.layoutIfNeeded()
            }
        }
        
    func showMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menuLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
