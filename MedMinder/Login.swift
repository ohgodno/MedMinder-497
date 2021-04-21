//
//  Login.swift
//  MedMinder
//
//  Created by Yasser Yassine on 3/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class Login: UIViewController {
    static var curEmail="default@poptarttechnology.edu"
    static var curPassword = "123"
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private let database = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterTapped(_ sender: Any) {
        //textView.text = "User Name: \(userNameField.text!)\nPassword: \(passwordField.text!)"
        FirebaseAuth.Auth.auth().signIn(withEmail: userNameField.text!, password: passwordField.text!, completion: { [weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else {
                strongSelf.incorrect()
                return
            }
            
            strongSelf.correct()
            print("You have signed in")
        })
    }
    @IBAction func signupTapped(_ sender: Any) {
        performSegue(withIdentifier: "signupSegue", sender: nil)
    }
    
    func correct(){
        Login.curEmail = userNameField.text!
        Login.curPassword = passwordField.text!
        
        var lowerBound = String.Index.init(encodedOffset: 0)
        var upperBound = String.Index.init(encodedOffset: userNameField.text!.count - 9)
        var urlString =  String(userNameField.text![lowerBound..<upperBound])
        
        Signup.choppedEmail = String(userNameField.text![lowerBound..<upperBound])
        
        
        database.child(Signup.choppedEmail).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["Name"] as? String ?? ""
            
            Signup.uname = username
        })
        
        
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    func incorrect(){
        let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .cancel,
                                      handler: {_ in}))
        present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordField.resignFirstResponder()
        userNameField.resignFirstResponder()
    }
    
    
}


extension Login : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
