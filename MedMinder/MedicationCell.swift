//
//  MedicationCell.swift
//  MedMinder
//
//  Created by Ali Hammoud on 4/4/21.
//

import UIKit

class MedicationCell: UITableViewCell {

    @IBOutlet weak var medicationTitleName: UILabel!
    
    /*func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
                let vc = nav.topViewController as? AboutViewController {
            vc.receivedString = String(medicationTitleName.text ?? "")
            print("WE C AME IN HERER BOYOUOUOUOUOU")
            }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
