//
//  TileMap.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 18/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import SpriteKit

/// An abstract struct that represents a tile map.
public struct TileMap {

    let size: CGSize
    let tileSize: CGSize
    let layers: [TileMapLayer]
    let objectGroups: [TileMapObjectGroup]
    let tileSet: SKTileSet
    
    var nodeSize: CGSize {
        CGSize(width: size.width * tileSize.width, height: size.height * tileSize.height)
    }
    
    init(size: CGSize, tileSize: CGSize, tileSets: [Tileset], layers: [TileMapLayer], objectGroups: [TileMapObjectGroup]) {
        self.size = size
        self.tileSize = tileSize
        self.layers = layers
        self.objectGroups = objectGroups
        
        var tileGroups: [SKTileGroup] = []
        tileSets.sorted(by: { $0.firstTileId < $1.firstTileId }).enumerated().forEach { (index, tileSet) in
            (0..<tileSet.rows).map({ CGFloat($0) }).forEach { y in
                (0..<tileSet.columns).map({ CGFloat($0) }).forEach { x in
                    let tileIndex: Int = Int(y) * tileSet.columns + Int(x) + tileSet.firstTileId
                    let cropOrigin: CGPoint = CGPoint(x: x * tileSet.tileSize.width,
                                                      y: y * tileSet.tileSize.height)
                    let tile: SKTexture = SKTexture(imageNamed: tileSet.textureName).cropped(origin: cropOrigin, size: tileSet.tileSize)
                    let tileDefinition: SKTileDefinition = SKTileDefinition(texture: tile)
                    let tileGroup: SKTileGroup = SKTileGroup(tileDefinition: tileDefinition)
                    tileGroup.name = String(tileIndex)
                    tileGroups.append(tileGroup)
                }
            }
        }
        tileSet = SKTileSet(tileGroups: tileGroups)
    }
    
}
