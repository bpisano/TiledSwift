//
//  XMLDecodable.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation
import CoreGraphics

protocol XMLDecodable {
    
    static func decode(attributes: [String: String]) -> Self?

}

extension XMLDecodable {
    
    static func integer(fromAttributes attributes: [String: String], key: String) -> Int? {
        guard let integerString = attributes[key] else { return nil }
        guard let integer = Int(integerString) else { return nil }
        return integer
    }
    
    static func point(fromAttributes attributes: [String: String], xKey: String = "x", yKey: String = "y") -> CGPoint? {
        guard let xString = attributes[xKey] else { return nil }
        guard let yString = attributes[yKey] else { return nil }
        guard let x = Double(xString) else { return nil }
        guard let y = Double(yString) else { return nil }
        return CGPoint(x: x, y: y)
    }
    
    static func size(fromAttributes attributes: [String: String], widthKey: String = "width", heightKey: String = "height") -> CGSize? {
        guard let widthString = attributes[widthKey] else { return nil }
        guard let heightString = attributes[heightKey] else { return nil }
        guard let width = Double(widthString) else { return nil }
        guard let height = Double(heightString) else { return nil }
        return CGSize(width: width, height: height)
    }
    
}
