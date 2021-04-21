//
//  Signup.swift
//  MedMinder
//
//  Created by Yasser Yassine on 3/31/21.
//
import FirebaseDatabase
import UIKit
import FirebaseAuth

class Signup: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    static var fname = ""
    static var lname = ""
    static var uname = ""
    static var choppedEmail = ""

    
    @IBOutlet weak var passWordConf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        emailAddress.delegate = self
        passWord.delegate = self
        confirmPassword.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           view.endEditing(true)
           return true
    }
    

    @IBAction func signupTapped(_ sender: Any) {
        
        
        
        let numbersRange = (passWord.text!).rangeOfCharacter(from: .decimalDigits)
        let hasNumbers = (numbersRange != nil)
        print(hasNumbers)
        if(!hasNumbers || (passWord.text!).count<8){
            let alert = UIAlertController(title: "Error", message: "Password must contain at least one numeric and at least 8 characters.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue",
                                          style: .cancel,
                                          handler: {_ in}))
            present(alert, animated: true)
            return
        }
        if(passWord.text! == passWordConf.text!){
        FirebaseAuth.Auth.auth().createUser(withEmail: emailAddress.text!, password: passWord.text!, completion: { [weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else {
                print(error!)
                print("Account creation failed")
                return
            }
            print("You have signed in")
            strongSelf.correct()

        })
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Password and confirmation password are not the same. Try again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue",
                                          style: .cancel,
                                          handler: {_ in}))
            present(alert, animated: true)
        }
    }
    
    func correct(){
        print("hiiii")
        Login.curEmail = emailAddress.text!
        Login.curPassword = passWord.text!
        
        Signup.fname = firstName.text!
        Signup.lname = lastName.text!
        let lowerBound = String.Index(utf16Offset: 0, in: emailAddress.text!)
        let upperBound = String.Index(utf16Offset: emailAddress.text!.count - 9, in: emailAddress.text!)
        Signup.choppedEmail = String(emailAddress.text![lowerBound..<upperBound])
        Signup.uname = Signup.fname + " " + Signup.lname
        UserDefaults.standard.setValue(Signup.fname, forKey: "fname")
        UserDefaults.standard.setValue(Signup.lname, forKey: "lname")
        UserDefaults.standard.setValue(Signup.choppedEmail, forKey: "choppedEmail")
        UserDefaults.standard.setValue(Signup.uname, forKey: "uname")
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        print(firstName.text!)
        print(lastName.text!)
        print(emailAddress.text!)
        ref.child(Signup.choppedEmail).setValue(["Name": firstName.text! + " " + lastName.text!])
        performSegue(withIdentifier: "signupLoginSegue", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

