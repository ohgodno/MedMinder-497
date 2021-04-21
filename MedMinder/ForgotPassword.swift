//
//  ForgotPassword.swift
//  MedMinder
//
//  Created by Yasser Yassine on 4/19/21.
//

import UIKit
import FirebaseAuth
class ForgotPassword: UIViewController {

    
    @IBOutlet weak var emailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendInstruct(_ sender: Any) {
        
        FirebaseAuth.Auth.auth().sendPasswordReset(withEmail: emailAddress.text!){ (error) in
            if let error=error {
                self.incorrect(errorMessage: error.localizedDescription)
                return
                
            }
        }
        correct()
    }
    
    func correct(){
        let alert = UIAlertController(title: "Success", message: "Instructions to reset your password has been emailed to you.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .cancel,
                                      handler: {_ in}))
        present(alert, animated: true)
        
    }
    
    func incorrect(errorMessage: String){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .cancel,
                                      handler: {_ in}))
        present(alert, animated: true)
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
