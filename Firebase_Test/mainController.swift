//
//  mainController.swift
//  Firebase_Test
//
//  Created by francisco.adan on 15/01/2020.
//  Copyright © 2020 francisco.adan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class mainController: UIViewController {

    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var tokenTextField: UILabel!
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if let user = Auth.auth().currentUser {
            Firestore.firestore().collection("Users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    
                    let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                } else {
                    
                    Firestore.firestore().collection("Users").whereField("email", isEqualTo: user.email!).getDocuments() { (querySnapshot, error) in
                        if let error = error {
                            
                            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                        } else {
                            self.welcomeMessage.text = "Bienvenido \(querySnapshot!.documents[0].data()["name"] as! String) \(querySnapshot!.documents[0].data()["lastname"] as! String)"
                            self.emailTextField.text = "Email: \(querySnapshot!.documents[0].data()["email"] as! String)"
                            self.tokenTextField.text = "Token: \(querySnapshot!.documents[0].documentID)"
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error al cerrar la sesión")
        }
    }
}
