//
//  Color+Extensions.swift
//  Connect4
//
//  Created by sergio joel camacho zarco on 07/07/23.
//

import Foundation
import SwiftUI

// extension to recover saved user color

extension Color : RawRepresentable{
    public var rawValue: String {
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        }catch{
            return ""
        }
        
    }
    
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else{
            self = .black // if not able to recover just assign black
            return
        }
        do{
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        }catch{
            self = .black
        }
    }
}
