//
//  XMLTileMapObject.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 19/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation
import CoreGraphics

internal struct XMLTileMapObject {
    
    let id: String
    let position: CGPoint
    let size: CGSize

}

extension XMLTileMapObject: XMLDecodable {
    
    static func decode(attributes: [String : String]) -> XMLTileMapObject? {
        guard let id = attributes["id"] else { return nil }
        guard let position = point(fromAttributes: attributes) else { return nil }
        guard let objectSize = size(fromAttributes: attributes) else { return nil }
        return XMLTileMapObject(id: id, position: position, size: objectSize)
    }
    
}

extension XMLTileMapObject: ToAppModelConvertible {
    
    func toAppModel() -> TileMapObject? {
        TileMapObject(id: id, position: position, size: size)
    }
    
}
