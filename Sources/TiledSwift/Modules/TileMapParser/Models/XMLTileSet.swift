//
//  XMLTileSet.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation
import CoreGraphics

internal struct XMLTileSet {
    
    let firstTileId: Int
    let name: String
    let tileSize: CGSize
    let tileCount: Int
    let columns: Int
    var image: String?

}

extension XMLTileSet: XMLDecodable {
    
    static func decode(attributes: [String : String]) -> XMLTileSet? {
        guard let firstTileId = integer(fromAttributes: attributes, key: "firstgid") else { return nil }
        guard let name = attributes["name"] else { return nil }
        guard let tileSize = size(fromAttributes: attributes, widthKey: "tilewidth", heightKey: "tileheight") else { return nil }
        guard let tileCount = integer(fromAttributes: attributes, key: "tilecount") else { return nil }
        guard let columns = integer(fromAttributes: attributes, key: "columns") else { return nil }
        return XMLTileSet(firstTileId: firstTileId, name: name, tileSize: tileSize, tileCount: tileCount, columns: columns, image: nil)
    }
    
}

extension XMLTileSet: ToAppModelConvertible {
    
    func toAppModel() -> Tileset? {
        guard let image = image?.split(separator: "/").last else { return nil }
        return Tileset(firstTileId: firstTileId,
                       name: name,
                       tileSize: tileSize,
                       tileCount: tileCount,
                       columns: columns,
                       textureName: String(image))
    }
    
}
