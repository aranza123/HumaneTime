//
//  ViewController.swift
//  HumaneTime
//
//  Created by Aranza Manriquez Alonso on 06/05/24.
//

import UIKit
import Alamofire

//Respuesta de la api
struct UserResponse: Codable {
    let error: Bool
    let codigo: String
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let url = "https://eland-dk.humaneland.net/HumaneTime/api/Authorization/AccesoUsuario"
    
    //Diccionario para mapear errores
    let message = ["ET216": "El Usuario no existe",
                   "ET217": "Password Invalido",
                   "ET221": "El formato del Email es invalido",
                   "ET222": "El Correo no existe"]
    
    //Guardamos popUp
    var popUp: Custom!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterButton.layer.cornerRadius = 10
        activityIndicator.isHidden = true
        
    }
    
    @IBAction func enterButtonClicked(_ sender: UIButton) {
        
        // Verificar que se hayan ingresado el correo y la contraseña
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Error: Debes ingresar un correo electrónico y una contraseña")
            return
        }
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Parámetros de la solicitud
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        //Solicitud POST a la API utilizando Alamofire, consumimos la api
        AF.request(url, method: .post, parameters: parameters).responseJSON { response in
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            switch response.result {
                case .success(let value):
                    // Manejar la respuesta exitosa
                    print("Respuesta exitosa:", value)
                    // Intentar mapear la respuesta a la estructura UserResponse
                    if let jsonData = response.data {
                        do {
                            let userResponse = try JSONDecoder().decode(UserResponse.self, from: jsonData)
                            
                            // Acceso a los datos mapeados
                            if userResponse.codigo == "ET000" {
                                self.performSegue(withIdentifier: "goToInformation", sender: self)
                            } else {
                                let errorMessage = self.message[userResponse.codigo] ?? "Error desconocido"
                                self.showPopUp(message: errorMessage)
                            }
                            
                        } catch {
                            print("Error al decodificar JSON:", error)
                        }
                    }
                case .failure(let error):
                    // si hay error y cual es
                    print("Error:", error)
            }
        }
    }
    //Para mostrar popUp
    func showPopUp(message: String) {
        popUp = Custom(frame: view.frame, message: message)
        view.addSubview(popUp)
        popUp.buttonAccept.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    //Para cerrar popUpc
    @objc func close() {
        self.popUp.removeFromSuperview()
    }
}

