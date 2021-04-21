//
//  Account.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import Foundation
import UIKit
import FirebaseAuth
class AccountView: UIViewController {
    
    @IBAction func accountEditSave(_ segue:UIStoryboardSegue){
        print("accountEditSave from editAccount")
    }
    
    @IBAction func accountEditCancel(_ segue:UIStoryboardSegue){
        print("accountEditCancel from editAccount")
    }
    @IBOutlet var name: UILabel!
    
    @IBAction func signOut(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to sign out?", preferredStyle: UIAlertController.Style.alert )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive){ (action) in
            return
        }
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.default){ (action) in
            do{
                try Auth.auth().signOut()
                
            }catch let err{
                print(err)
            }
            self.signoutTransition()
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(signOutAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    func signoutTransition(){
        performSegue(withIdentifier: "signedOut", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        name.text = Signup.uname
    }


}
