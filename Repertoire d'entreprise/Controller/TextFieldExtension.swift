//
//  TextFieldExtension.swift
//  Repertoire d'entreprise
//
//  Created by Riad Korimbacus on 22/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

extension AjoutController: UITextFieldDelegate {
    
    func miseEnplaceTextField() {
        
        prenomTextField.delegate = self
        nomTextField.delegate = self
        telTextField.delegate = self
        mailTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        view.endEditing(true)
        return true
    }
}
