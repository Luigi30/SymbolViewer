//
//  SymbolLoader.swift
//  SymbolViewer
//
//  Created by Kate on 5/31/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Cocoa
import os.log

enum SymbolLoaderError: Error {
    case invalidPath
    case invalidFile
}

class SymbolLoader: NSObject {
    let docLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "SymbolLoader")
    var symbols = [VlinkSymbol]()
    
    func loadFromFile(path: String) {
        symbols.removeAll()

        do {
            let text = try String(contentsOfFile: path)
            
            text.enumerateLines { line, _ in
                let symbolText = line.split(separator: " ")
                let symbol = VlinkSymbol(_name: String(symbolText[2]),
                                         _type: String(symbolText[1]),
                                         _address: UInt32(symbolText[0], radix: 16)!)
                self.symbols.append(symbol)
            }
        } catch {
            symbols.removeAll()
        }

    }
}
