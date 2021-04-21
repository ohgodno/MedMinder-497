//
//  ViewController.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import Foundation
import UIKit



class MedicationView: UITableViewController {
    
    public var newMed = Medication("tylenol", dosage: "50mg", shape: "capsule", color: "white", expiration: NSDate(), whenToTake: "Once per day")
    
    // MY CODE
    static var medicationList = [Medication]()
    static var start = true
    
    public class func saveMedicationList(_ value: [Medication]) {
        //print(value)
        
        
        if(MedicationView.start){
            MedicationView.start = false
            return
        }
        
        
        
        print("savemed")
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: "medicationList")
        }
        
        
    }

    public class func loadMedicationList() -> [Medication] {
        saveMedicationList( MedicationView.medicationList)
        print("something")
                
        if let medicationData = UserDefaults.standard.object(forKey: "medicationList") as? Data {
            if let medicationList = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(medicationData) as? [Medication] {
                return medicationList
            }
        }
        
        
        return [Medication]()
    }
    
    @IBAction func addMedSave(_ segue:UIStoryboardSegue){
        print("addMedSave from addMedication OKOK")
        print("newMed: \(dump(newMed))")
        MedicationView.medicationList.append(newMed)
        MedicationView.saveMedicationList(MedicationView.medicationList)
        tableView.reloadData()
    }
    
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationView.medicationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath)
        cell.textLabel?.text = MedicationView.medicationList[indexPath.row].NAME
        cell.detailTextLabel?.text = MedicationView.medicationList[indexPath.row].DOSAGE
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        let vc = storyboard?.instantiateViewController(identifier: "AboutViewController") as? AboutViewController
        vc?.receivedString = String(MedicationView.medicationList[indexPath.row].NAME ?? "")
        vc?.receivedDosage = String(MedicationView.medicationList[indexPath.row].DOSAGE ?? "")
        vc?.receivedRxNum = String(MedicationView.medicationList[indexPath.row].RXCUI)
        vc?.indexPath = indexPath
        let df = DateFormatter()
        let date = MedicationView.medicationList[indexPath.row].EXPIRATION // get todays date
        df.dateFormat = "MM/dd/yyyy"
        
        let stringDate: String = df.string(from: date as Date)
        
        
        
        vc?.receivedDate = stringDate
        vc?.receivedInterval = String(MedicationView.medicationList[indexPath.row].WHENTOTAKE)
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    /*let indexPath = IndexPath()*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ConflictsViewController {
            let vc = segue.destination as? ConflictsViewController
            vc?.fullMedicationList = MedicationView.medicationList
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MedicationView.medicationList = MedicationView.loadMedicationList()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


