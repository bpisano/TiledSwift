//
//  Tileset.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 18/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import SpriteKit

/// An abstract struct that represents a tileset used in a tile map.
public struct Tileset {

    let firstTileId: Int
    let name: String
    let tileSize: CGSize
    let tileCount: Int
    let columns: Int
    let textureName: String
    
    var rows: Int {
        tileCount / columns
    }
        
}
