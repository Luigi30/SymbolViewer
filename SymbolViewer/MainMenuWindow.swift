//
//  MainMenuWindow.swift
//  SymbolViewer
//
//  Created by Kate on 6/1/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Cocoa

class MainMenuWindow: NSWindow {

    @IBOutlet weak var symbolTableView: NSTableView!
    
    @IBAction func openDocument(_ sender: Any) {
        print("openDocument!")
    }
    
    var symbolLoader = SymbolLoader()
    
    func setupTableView() {
        symbolTableView.delegate = self
        symbolTableView.dataSource = self
        symbolLoader.loadFromFile(path: "/Users/luigi/68k-sbc/bootrom/bootrom.sym")
        symbolTableView.reloadData()
    }
    
}

extension MainMenuWindow: NSTableViewDataSource {
    /* TableViewDataSource stuff */
    func numberOfRows(in tableView: NSTableView) -> Int {
        return symbolLoader.symbols.count
    }
}

extension MainMenuWindow: NSTableViewDelegate {
    fileprivate enum CellIdentifiers {
        static let nameCell = "SymbolNameCellID"
        static let addressCell = "SymbolAddressCellID"
        static let typeCell = "SymbolTypeCellID"
        static let scopeCell = "SymbolScopeCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var cellID: String = ""
        var cellText: String = ""
        
        if symbolLoader.symbols.isEmpty {
            return nil
        }
        
        let symbol = symbolLoader.symbols[row]
        
        if tableColumn == tableView.tableColumns[0] {
            cellID = CellIdentifiers.nameCell
            cellText = symbol.name
        }
        else if tableColumn == tableView.tableColumns[1] {
            cellID = CellIdentifiers.addressCell
            cellText = String.init(format: "$%06X", symbol.address)
        }
        else if tableColumn == tableView.tableColumns[2] {
            cellID = CellIdentifiers.typeCell
            cellText = symbol.typeFriendly
        }
        else if tableColumn == tableView.tableColumns[3] {
            cellID = CellIdentifiers.scopeCell
            cellText = symbol.scope
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellID), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = cellText
            return cell
        }
        
        return nil
    }
}
