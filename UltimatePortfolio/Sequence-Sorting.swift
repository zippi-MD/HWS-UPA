//
//  Sequence-Sorting.swift
//  UltimatePortfolio
//
//  Created by Alejandro Mendoza on 14/02/22.
//

import Foundation
import UIKit

extension Sequence {
    func sorted<Value>(by keypath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keypath], $1[keyPath: keypath])
        }
    }
    
    func sorted<Value: Comparable>(by keypath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keypath, using: <)
    }
    
    func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
        self.sorted {
            sortDescriptor.compare($0, to: $1) == .orderedAscending
        }
    }
    
    func sorted(by sortDescriptors: [NSSortDescriptor]) -> [Element] {
        self.sorted {
            for descriptor in sortDescriptors {
                switch descriptor.compare($0, to: $1) {
                case .orderedAscending:
                    return true
                case .orderedDescending:
                    return false
                case .orderedSame:
                    continue
                }
            }
            
            return false
        }
    }
}
