//
//  Bookmarklist.swift
//  Loop_Demo
//
//  Created by MOKSHA on 24/11/22.
//

import Foundation
import UIKit


class Bookmarklist {
    enum PlistError: Error {
        case FileNotWritten
        case FileDoesNotExist
    }
    
    private let name: String
    
    private var sourcePath: String? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return nil }
        return path
    }
    
    private var destPath: String? {
        guard sourcePath != nil else { return nil }
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (dir as NSString).appendingPathComponent("\(name).plist")
    }
    
    // MARK: - Lifecycle
    
    required init?(name: String) {
        self.name = name
        
        let fileManager = FileManager.default
        
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExists(atPath: source) else { return nil }
        
        if !fileManager.contentsEqual(atPath: source, andPath: destination) {
            if !fileManager.fileExists(atPath: destination) {
                do {
                    try fileManager.copyItem(atPath: source, toPath: destination)
                } catch let error as NSError {
                    print("Unable to copy file. ERROR: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func getValues() -> Array<Moives>? {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSArray(contentsOfFile: destPath!) as? NSArray else { return nil }
            return dict as! Array<Moives>
        } else {
            return nil
        }
    }
    
    func addValuesToplist(dictionary:NSDictionary) throws {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            if !dictionary.write(toFile: destPath!, atomically: false) {
                print("Plist file not written successfully.")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }
}
