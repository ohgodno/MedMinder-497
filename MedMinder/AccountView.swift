//
//  Account.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import Foundation
import UIKit

class AccountView: UIViewController {
    
    @IBAction func accountEditSave(_ segue:UIStoryboardSegue){
        print("accountEditSave from editAccount")
    }
    
    @IBAction func accountEditCancel(_ segue:UIStoryboardSegue){
        print("accountEditCancel from editAccount")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
