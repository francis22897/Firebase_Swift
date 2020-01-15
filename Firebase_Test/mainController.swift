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
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if let user = Auth.auth().currentUser {
            Firestore.firestore().collection("Users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    
                    let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                } else {
                    
                    var ok = false
                    for document in querySnapshot!.documents {
                        let documentEmail: String = document.data()["email"] as! String
                        let userEmail: String = user.email!
                        
                        if (documentEmail == userEmail){
                            ok = true
                            self.welcomeMessage.text = "Bienvenido \(document.data()["name"]!) \(document.data()["lastname"]!)"
                            break
                        }
                        
                    }
                    
                    if !ok {
                        
                        let alert = UIAlertController(title: "Error", message: "No hay datos del usuario logueado", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
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
