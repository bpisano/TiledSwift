//
//  XMLTileMapObjectGroup.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 19/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation

internal struct XMLTileMapObjectGroup {
    
    let id: String
    let name: String
    var objects: [XMLTileMapObject]

}

extension XMLTileMapObjectGroup: XMLDecodable {
    
    static func decode(attributes: [String : String]) -> XMLTileMapObjectGroup? {
        guard let id = attributes["id"] else { return nil }
        guard let name = attributes["name"] else { return nil }
        return XMLTileMapObjectGroup(id: id, name: name, objects: [])
    }
    
}

extension XMLTileMapObjectGroup: ToAppModelConvertible {
    
    func toAppModel() -> TileMapObjectGroup? {
        TileMapObjectGroup(id: id,
                           name: name,
                           objects: objects.compactMap({ $0.toAppModel() }))
    }
    
}
