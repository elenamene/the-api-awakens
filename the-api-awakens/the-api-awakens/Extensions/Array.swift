//
//  Array.swift
//  the-api-awakens
//
//  Created by Elena Meneghini on 06/06/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

extension Array where Element: Character {
    var smallest: Character? {
        let arrayOfValidHeights = self.filter { Int($0.height) != nil }
        let sortedArray = arrayOfValidHeights.sorted(by:{
            let lhsHeight = Int($0.height)!
            let rhsHeight = Int($1.height)!
            return  lhsHeight < rhsHeight
        })
        
        return sortedArray.first
    }
    
    var largest: Character? {
        let arrayOfValidHeights = self.filter { Int($0.height) != nil }
        let sortedArray = arrayOfValidHeights.sorted(by:{
            let lhsHeight = Int($0.height)!
            let rhsHeight = Int($1.height)!
            return  lhsHeight < rhsHeight
        })
        
        return sortedArray.last
    }
}

extension Array where Element: Starship {
    var smallest: Starship? {
        let arrayOfValidLengths = self.filter { Int($0.length) != nil }
        let sortedArray = arrayOfValidLengths.sorted(by:{
            let lhs = Double($0.length)!
            let rhs = Double($1.length)!
            return  lhs < rhs
        })
        
        return sortedArray.first
    }
    
    var largest: Starship? {
        let arrayOfValidLengths = self.filter { Int($0.length) != nil }
        let sortedArray = arrayOfValidLengths.sorted(by:{
            let lhs = Double($0.length)!
            let rhs = Double($1.length)!
            return  lhs < rhs
        })
        
        return sortedArray.last
    }
}

extension Array where Element: Vehicle {
    var smallest: Vehicle? {
        let arrayOfValidLengths = self.filter { Int($0.length) != nil }
        let sortedArray = arrayOfValidLengths.sorted(by:{
            let lhs = Double($0.length)!
            let rhs = Double($1.length)!
            return  lhs < rhs
        })
        
        return sortedArray.first
    }
    
    var largest: Vehicle? {
        let arrayOfValidLengths = self.filter { Int($0.length) != nil }
        let sortedArray = arrayOfValidLengths.sorted(by:{
            let lhs = Double($0.length)!
            let rhs = Double($1.length)!
            return  lhs < rhs
        })
        
        return sortedArray.last
    }
}

extension Array where Element: Film {
    var smallest: Film? {
        return self.sorted(by: { $0.releaseDate < $1.releaseDate }).first
    }
    
    var largest: Film? {
        return self.sorted(by: { $0.releaseDate < $1.releaseDate }).last
    }
}


