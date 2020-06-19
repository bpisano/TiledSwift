//
//  XMLTileMap.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation
import CoreGraphics

internal struct XMLTileMap {

    var tileSets: [XMLTileSet] = []
    var layers: [XMLTileMapLayer] = []
    var objectGroups: [XMLTileMapObjectGroup] = []
    let size: CGSize
    let tileSize: CGSize
    
}

extension XMLTileMap: XMLDecodable {
    
    static func decode(attributes: [String : String]) -> XMLTileMap? {
        guard let mapSize = size(fromAttributes: attributes) else { return nil }
        guard let tileSize = size(fromAttributes: attributes, widthKey: "tilewidth", heightKey: "tileheight") else { return nil }
        return XMLTileMap(size: mapSize, tileSize: tileSize)
    }
    
}

extension XMLTileMap: ToAppModelConvertible {
    
    func toAppModel() -> TileMap? {
        TileMap(size: size,
                tileSize: tileSize,
                tileSets: tileSets.compactMap({ $0.toAppModel() }),
                layers: layers.compactMap({ $0.toAppModel() }),
                objectGroups: objectGroups.compactMap({ $0.toAppModel() }))
    }
    
}
