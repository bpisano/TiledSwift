//
//  TileMapNodeObjectGroup.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 19/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import SpriteKit

/// A struct that represent a group of objects in a `TileMapNode`.
public struct TileMapNodeObjectGroup {
    
    let id: String
    let name: String
    let nodes: [SKSpriteNode]

}
