//
//  Medication.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//
import Foundation
import SwiftyJSON
import Alamofire

public class Medication: NSObject, NSCoding {
    
    var NAME: String!
    var DOSAGE: String!
    var EXPIRATION: NSDate
    var WHENTOTAKE: String
    var COLOR: String
    var SHAPE: String
    var COLOR_CODE: String
    var SHAPE_CODE: String
    var NDC: Int
    var RXCUI: Int
    
    init(_ name: String, dosage: String, shape:String, color:String, expiration: NSDate, whenToTake: String){
        let shapeCodes:[String:String] = [
            "bullet":"C48335",
            "capsule":"C48336",
            "clover":"C48337",
            "diamond":"C48338",
            "double circle":"C48339",
            "freform":"C48340",
            "gear":"C48341",
            "heptagon":"C48342",
            "hexagon":"C48343",
            "octagon":"C48344",
            "oval":"C48345",
            "pentagon":"C48346",
            "rectangle":"C48347",
            "round":"C48348",
            "semi-circle":"C48349",
            "square":"C48350",
            "tear":"C48351",
            "trapezoid":"C48352",
            "triangle":"C48353", "":""]
        let colorCodes:[String:String] = [
            "red":"C48326",
            "orange":"C48331",
            "yellow":"C48330",
            "green":"C48329",
            "turquoise":"C48334",
            "blue":"C48333",
            "pink":"C48328",
            "purple":"C48327",
            "brown":"C48332",
            "white":"C48325",
            "gray":"C48324",
            "black":"C48323", "":""]
        func getRXCUI() -> Int {
            return 1
        }
        func getNDC() -> Int {
            return 2
        }
        self.NAME       = name
        self.DOSAGE     = dosage
        self.COLOR      = color.lowercased()
        self.SHAPE      = shape.lowercased()
        self.COLOR_CODE = colorCodes[color.lowercased()]!
        self.SHAPE_CODE = shapeCodes[shape.lowercased()]!
        self.EXPIRATION = expiration
        self.WHENTOTAKE = whenToTake
        self.NDC        = getNDC()
        self.RXCUI      = getRXCUI()
        print("NDC: \(self.NDC)")
        print("RXCUI: \(self.RXCUI)")
    }
    
    public required init(coder decoder: NSCoder) {
        NAME       = decoder.decodeObject(forKey: "NAME") as? String
        DOSAGE     = decoder.decodeObject(forKey: "DOSAGE") as? String
        COLOR      = decoder.decodeObject(forKey: "COLOR") as! String
        SHAPE      = decoder.decodeObject(forKey: "SHAPE") as! String
        COLOR_CODE = decoder.decodeObject(forKey: "COLOR_CODE") as! String
        SHAPE_CODE = decoder.decodeObject(forKey: "SHAPE_CODE") as! String
        EXPIRATION = decoder.decodeObject(forKey: "EXPIRATION") as! NSDate
        WHENTOTAKE = decoder.decodeObject(forKey: "WHENTOTAKE") as! String
        NDC        = decoder.decodeInteger(forKey: "NDC")
        RXCUI      = decoder.decodeInteger(forKey: "RXCUI")
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.NAME,       forKey: "NAME")
        coder.encode(self.DOSAGE,     forKey: "DOSAGE")
        coder.encode(self.COLOR,      forKey: "COLOR")
        coder.encode(self.SHAPE,      forKey: "SHAPE")
        coder.encode(self.COLOR_CODE, forKey: "COLOR_CODE")
        coder.encode(self.SHAPE_CODE, forKey: "SHAPE_CODE")
        coder.encode(self.EXPIRATION, forKey: "EXPIRATION")
        coder.encode(self.WHENTOTAKE, forKey: "WHENTOTAKE")
        coder.encode(self.NDC,        forKey: "NDC")
        coder.encode(self.RXCUI,      forKey: "RXCUI")
    }
    
    
}
