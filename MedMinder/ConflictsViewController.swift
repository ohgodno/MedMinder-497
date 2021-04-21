//
//  ConflictsViewController.swift
//  MedMinder
//
//  Created by Ali Hammoud on 4/9/21.
//

import UIKit
import SwiftyJSON

class ConflictsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var conflictsTable: UITableView!
    
    public var fullMedicationList = [Medication]()
    public var fullConflictsList = [String()]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return fullConflictsList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ConflictsCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConflictsCell") as! ConflictsCell
    
        cell.lblText.text! = fullConflictsList[indexPath.row]
        //cell.textLabel?.text = fullConflictsList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        let marginGuide = header.contentView.layoutMarginsGuide
        let label = UILabel()
        label.text = "Conflicts"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        header.contentView.addSubview(label)
        //This constant only works for the iphone 12
        var constraint = label.widthAnchor.constraint(equalToConstant: 207)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        constraint = label.topAnchor.constraint(equalTo: marginGuide.topAnchor)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        constraint = label.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        constraint = label.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        return header
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        conflictsTable.estimatedRowHeight = 21
        conflictsTable.rowHeight = UITableView.automaticDimension
    }
    
    
    func interactionAPI(urlString: String) -> String {
        var stuff = String()
        // Create URL
        let url = URL(string: urlString)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                //Can store this stuff in firebase database
                stuff = dataString
            }
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return stuff
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(fullMedicationList.count == 0){
            return
        }
        var combinedMedicationRX = ""
        for medication in fullMedicationList {
            var anotherThing = Int()
            if let testing = medication.RXCUI as? Int{
                anotherThing = testing
            }
            combinedMedicationRX += String(anotherThing) + "+"
            print(medication.NAME! + " : " + medication.DOSAGE! + " : " + String(anotherThing))
        }
        let lowerBound = String.Index.init(encodedOffset: 0)
        let upperBound = String.Index.init(encodedOffset: combinedMedicationRX.count - 1)
        let urlString = "https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=" + String(combinedMedicationRX[lowerBound..<upperBound])
        //let urlString = "https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=207106+152923+656659"
        let apiResults = interactionAPI(urlString: urlString)
        let dataStuff: Data? = apiResults.data(using: .utf8)
        let json = try? JSON(data: dataStuff!)
        let allInteractions = json?["fullInteractionTypeGroup"][0]["fullInteractionType"]
        for (_, subJson) in allInteractions! {
            for (_, interaction) in subJson["interactionPair"]{
                fullConflictsList.append(interaction["description"].string!)
            }
        }
        // Removing empty strings
        fullConflictsList = fullConflictsList.filter({ $0 != ""})
        fullConflictsList = Array(Set(fullConflictsList))
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
