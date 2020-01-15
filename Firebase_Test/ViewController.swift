//
//  ViewController.swift
//  Firebase_Test
//
//  Created by francisco.adan on 13/01/2020.
//  Copyright © 2020 francisco.adan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    

    @IBAction func loginAction(_ sender: Any) {
        let email = self.emailField.text
        let password = self.passwordField.text
        
        if email!.isEmpty || password!.isEmpty {
            
            let alert = UIAlertController(title: "Error", message: "Debes rellenar los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            
            Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if let user = authResult?.user {
                    
                    self!.performSegue(withIdentifier: "loginSegue", sender: nil)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self!.present(alert, animated: true)
                    
                }
            }
        }
    }
    
    @IBAction func recoverPassAction(_ sender: Any) {
        
        let email = self.emailField.text
        
        if email!.isEmpty  {
            
            let alert = UIAlertController(title: "Error", message: "Debes rellenar el email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            Auth.auth().sendPasswordReset(withEmail: email!) { error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Email enviado", message: "Comprueba tu email para restaurar la contraseña", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

