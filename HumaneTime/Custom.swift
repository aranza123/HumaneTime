//  Custom.swift
//  HumaneTime
//
//  Created by Aranza Manriquez Alonso on 07/05/24.
//

import UIKit

class Custom: UIView {
    
    var vc: UIViewController!
    
    @IBOutlet weak var buttonAccept: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    
    var message: String!
    
    //metodo de inicializacion cuando se crea através de un archivo xib
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Inicialización
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //Carga del mensaje
    convenience init(frame: CGRect, message: String) {
        self.init(frame: frame)
        self.message = message
        xibSetup()
    }
    
    //Configuracion de la vista xib
    func xibSetup() {
        let view = loadNibView()
        view.frame = bounds
        addSubview(view)
        labelMessage.text = message
    }
    
    //Carga de la vista desde el archivo xib 
    func loadNibView() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomPopUp", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
