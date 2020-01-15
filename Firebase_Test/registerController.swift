//
//  registerController.swift
//  Firebase_Test
//
//  Created by francisco.adan on 15/01/2020.
//  Copyright © 2020 francisco.adan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class registerController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {

    }
    
    @IBAction func registerAction(_ sender: Any) {
        let name = nameTextField.text
        let lastname = lastnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if email!.isEmpty || password!.isEmpty {
            
            let alert = UIAlertController(title: "Error", message: "Debes rellenar los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            
            Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
                if let user = authResult?.user {
                    
                    let db = Firestore.firestore()
                    var docRef: DocumentReference? = nil
                    docRef = db.collection("Users").addDocument(data: [
                        "email": email!,
                        "name": name!,
                        "lastname": lastname!
                    ]) { err in
                        if let err = err {
                            
                            let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                        } else {
                            
                            self.performSegue(withIdentifier: "registerSegue", sender: nil)
                            
                        }
                    }
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }
        }
    }
}
