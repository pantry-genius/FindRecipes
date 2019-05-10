//
//  LoginController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/9/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let logoContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        //textField.addTarget(nil, action: #selector(handlerTextInputChange), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
       let pf = UITextField()
        pf.placeholder = "Password"
        pf.isSecureTextEntry = true
        pf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        pf.borderStyle = .roundedRect
        pf.font = UIFont.systemFont(ofSize: 14)
        //pf.addTarget(nil, action: #selector(handlerTextInputChange), for: .editingChanged)
        return pf
        
    }()
    
//    @objc func handlerTextInputChange() {
//
//    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
            if let err = err {
                print("failed to log in ", err )
            }
            
            
            
            
            
        }
    }
    
    
    
}
