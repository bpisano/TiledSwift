//
//  TileMapNodeRepresentable.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 19/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import SpriteKit

/// A protocol used to represent a `TileMapNode`.
public protocol TileMapNodeRepresentable {
    
    /// The layers of a `TileMapNode` used to displays tiles.
    var layers: [TileMapNodeLayer] { get }
    /// The object groups of a `TilemapNode` used for colisions or interactions.
    var objectGroups: [TileMapNodeObjectGroup] { get }
    
    /// Returns the layer in a `TileMapNode` with a given name.
    /// - Parameter layerName: the name of the layer to fetch.
    func layer(named layerName: String) -> TileMapNodeLayer?
    
    /// Returns a group of objects in a `TileMapNode` with a given name.
    /// - Parameter objectGroupName: the name of the object group.
    func objectGroup(named objectGroupName: String) -> TileMapNodeObjectGroup?
    
    /// Apply a `SKPhysicsBody` to all objects in a group.
    /// - Parameters:
    ///   - physicsBody: the `SKPhysicsBody` to apply.
    ///   - objectGroupName: the name of the object group.
    func setPhysicsBody(_ physicsBody: SKPhysicsBody, toObjectsInGroupNamed objectGroupName: String)
    
}
