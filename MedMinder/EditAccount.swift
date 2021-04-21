//
//  EditAccount.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import SwiftyJSON
import Alamofire
import JVFloatLabeledTextField
import Foundation
import UIKit
import FirebaseAuth
class EditAccount:
UITableViewController {
static var successful=true
    @IBOutlet var emailAddress: JVFloatLabeledTextField!
    
    @IBOutlet var currentPassword: JVFloatLabeledTextField!
    
    
    @IBOutlet var newPassword: JVFloatLabeledTextField!
    
    @IBOutlet var newPasswordR: JVFloatLabeledTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        let numbersRange = (newPassword.text!).rangeOfCharacter(from: .decimalDigits)
        let hasNumbers = (numbersRange != nil)
        print(hasNumbers)
        if(!hasNumbers || (newPassword.text!).count<8){
            let alert = UIAlertController(title: "Error", message: "Password must contain at least one numeric and at least 8 characters.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue",
                                          style: .cancel,
                                          handler: {_ in}))
            present(alert, animated: true)
            return
        }
        
        if(newPassword.text! != newPasswordR.text!){
            let alert = UIAlertController(title: "Error", message: "Both new password fields must match.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue",
                                          style: .cancel,
                                          handler: {_ in}))
            present(alert, animated: true)
            return
        }
        let user = Auth.auth().currentUser
        
        var credential: AuthCredential = EmailAuthProvider.credential(withEmail: Login.curEmail, password: currentPassword.text!)
        user?.reauthenticate(with: credential, completion:{ (authResult, error) in
            if let error = error {
                self.errorIn(location: "UA")
                print("Incorrect authentication")
                return
            }
            else{
                self.authenticated()
                
                
            }
        })

        
    }
    
    func authenticated(){
        Auth.auth().currentUser?.updatePassword(to: newPassword.text!){ (error) in
            if error != nil {
                self.errorIn(location: "UP")
                print("Incorrect password")
                return
            }
            else{
            }
        }
        
        Auth.auth().currentUser?.updateEmail(to: emailAddress.text!){ (error) in
            if error != nil {
                self.errorIn(location: "UE")
                print("Incorrect Email")
                return
            }
            else{
                self.onSuccess()
            }
        }


        
    }
    func onSuccess(){
        print("Successful: ")
        print(EditAccount.successful)
        let alert = UIAlertController(title: "Success", message: "Your credentials have been updated.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .cancel,
                                      handler: {_ in}))
        present(alert, animated: true)
        Login.curPassword = newPassword.text!
        Login.curEmail = emailAddress.text!
    }
    func errorIn(location: String){
        var message = "dad joke"
        print("Heree")
        EditAccount.successful = false
        if(location == "UE"){
            message = "Error in updating email, did you provide a valid email?"
        }
        else if(location == "UP"){
            message = "Error in updating password."
        }
        else{
            EditAccount.successful = true
            message = "Error in authenticating."
        }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .cancel,
                                      handler: {_ in}))
        present(alert, animated: true)
    }
    
}
