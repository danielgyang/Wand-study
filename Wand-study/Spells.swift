//
//  Spells.swift
//  Wand-study
//
//  Created by Daniel Yang on 11/17/19.
//  Copyright © 2019 Daniel Yang. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Spells {
    var spellData: [SpellData] = []
    
    func getSpells(completed: @escaping () -> ()) {
        let spellsURL = "http://potterspells.herokuapp.com/api/v1/spells"
        Alamofire.request(spellsURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
//                print(value)
                let json = JSON(value)
                let totalSpells = json["results"].count
                for index in 0..<totalSpells {
                    let name = json["results"][index]["name"].stringValue
                    let description = json["results"][index]["description"].stringValue
                    let soundFile =  json["results"][index]["soundFile"].stringValue
                    self.spellData.append(SpellData(name: name, description: description, soundFile: soundFile))
                    print("\(index). \(name) \(description) \(soundFile)")
                }
            case .failure(let error):
                print("ERROR: \(error) while retrieving data from url \(spellsURL)")
            }
        }
        completed()
    }
}
