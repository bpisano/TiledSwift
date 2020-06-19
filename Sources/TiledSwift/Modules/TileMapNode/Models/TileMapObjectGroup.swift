//
//  TileMapObjectGroup.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 19/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation

/// An abstract struct that represents a group of objects in a tile map.
public struct TileMapObjectGroup {

    let id: String
    let name: String
    let objects: [TileMapObject]
    
}
