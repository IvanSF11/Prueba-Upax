//
//  DebugLog.swift
//  Prueba Upax
//
//  Created by Ivan Soriano on 31/05/22.
//

import Foundation

public enum DebugModule: String { case mainTable, graphs, networking }

public func debugLog(_ message: String, in module: DebugModule? = nil, with error: Error? = nil) {
    var moduleString = ""
    var errorString = ""
    
    if let module = module {
        moduleString = "[\(module.rawValue)]"
    }
    
    if let error = error {
        errorString = "with error message: \(error.localizedDescription)"
    }

    print("DEBUG:", moduleString, message, errorString)
}
