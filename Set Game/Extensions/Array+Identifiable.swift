//
//  Array+Identifiable.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 8/31/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import Foundation

extension Array where Element:Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
