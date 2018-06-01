//
//  VlinkSymbol.swift
//  SymbolViewer
//
//  Created by Kate on 5/31/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Cocoa

class VlinkSymbol: NSObject {
    var name: String
    var type: String //TODO: enum
    var address: UInt32
    
    init(_name: String, _type: String, _address: UInt32)
    {
        name = _name
        type = _type
        address = _address
    }
    
    var typeFriendly: String {
        let c = type.lowercased().first
        
        switch c {
        case "a":
            return "Absolute"
        case "b":
            return "BSS"
        case "d":
            return "Data"
        case "t":
            return "Code"
        default:
            return type
        }
    }
    
    var scope: String {
        if type.lowercased() != type
        {
            return "Global"
        }
        else
        {
            return "Local"
        }
    }
}
