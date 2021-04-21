//
//  AboutViewController.swift
//  MedMinder
//
//  Created by Ali Hammoud on 4/2/21.
//

import UIKit
import Foundation
import SwiftyJSON


class AboutViewController: UIViewController {

    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var rxNorm: UILabel!
    
    @IBOutlet weak var medicationDosage: UILabel!
    @IBOutlet weak var changingTitle: UILabel!
    
    @IBOutlet var date: UILabel!
    
    @IBOutlet var interval: UILabel!
    
    var receivedString = ""
    var receivedDosage = ""
    var receivedRxNum = ""
    var receivedDate = ""
    var receivedInterval = ""
    var indexPath = IndexPath()
    var newMedicationList = [Medication]()
    override func viewDidLoad() {
        super.viewDidLoad()
        changingTitle.text = receivedString
        medicationDosage.text = "Dosage:" + receivedDosage
        rxNorm.text = "RXNormID: " + receivedRxNum
        
        date.text = "Date entered: " + receivedDate
        
        interval.text = "Interval: " +   receivedInterval
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteMedication(_ sender: Any) {
        print(MedicationView.medicationList)
        MedicationView.medicationList.remove(at: indexPath.row)
        performSegue(withIdentifier: "deleted", sender: nil)
    }
    //This keeps resetting even when screen is only slid down a bit
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*let stuff = apiCall(urlString: "https://rxnav.nlm.nih.gov/REST/Prescribe/rxcui.json?name=" + receivedString)
        let dataStuff: Data? = stuff.data(using: .utf8)
        let json = try? JSON(data: dataStuff!)
        if let rxnormid = json?["idGroup"]["rxnormId"][0].string {
            // Add this to firebase and access it inside of conflicts api request
            rxNorm.text = "RxnormID: " + rxnormid
        }*/
        //var sepString = urlString.split(separator: "=")
        //changingTitle.text = String(sepString.last ?? "")
        changingTitle.textAlignment = NSTextAlignment.center
        
        
        //Add dosage and image of medication
        //https://rxnav.nlm.nih.gov/RxImageAPIParameters.html
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
