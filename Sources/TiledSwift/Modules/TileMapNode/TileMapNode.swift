//
//  TileMapNode.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import SpriteKit

/// A class that represents a tile map with multiple layers and objects.
public final class TileMapNode: SKSpriteNode, TileMapNodeRepresentable {
    
    private(set) public var layers: [TileMapNodeLayer] = []
    private(set) public var objectGroups: [TileMapNodeObjectGroup] = []
    
    public init(tileMap: TileMap) {
        super.init(texture: nil, color: .clear, size: tileMap.nodeSize)
        configureLayers(from: tileMap)
        configureObjects(from: tileMap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layer(named layerName: String) -> TileMapNodeLayer? {
        layers.first(where: { $0.name == layerName })
    }
    
    public func objectGroup(named objectGroupName: String) -> TileMapNodeObjectGroup? {
        objectGroups.first(where: { $0.name == objectGroupName })
    }
    
    public func setPhysicsBody(_ physicsBody: SKPhysicsBody, toObjectsInGroupNamed objectGroupName: String) {
        objectGroup(named: objectGroupName)?.nodes.forEach({ node in
            node.physicsBody = physicsBody
        })
    }
    
}

// MARK: - TileMap Configuration

extension TileMapNode {
    
    private func configureLayers(from tileMap: TileMap) {
        tileMap.layers.forEach { layer in
            let tileMapNode: SKTileMapNode = skTileMapNode(from: layer, tileMap: tileMap)
            let tileMapNodeLayer: TileMapNodeLayer = TileMapNodeLayer(id: layer.id, name: layer.name, tileMap: tileMapNode)
            layers.append(tileMapNodeLayer)
            addChild(tileMapNode)
        }
    }
    
    private func configureObjects(from tileMap: TileMap) {
        tileMap.objectGroups.forEach { objectGroup in
            let tileMapNodeObjects: [SKSpriteNode] = objectGroup.objects.map({ skSpriteNode(from: $0, tileMap: tileMap) })
            let tileMapNodeObjectGroup: TileMapNodeObjectGroup = TileMapNodeObjectGroup(id: objectGroup.id, name: objectGroup.name, nodes: tileMapNodeObjects)
            objectGroups.append(tileMapNodeObjectGroup)
            tileMapNodeObjects.forEach { node in
                addChild(node)
            }
        }
    }
    
    private func skTileMapNode(from layer: TileMapLayer, tileMap: TileMap) -> SKTileMapNode {
        let skTileMapNode: SKTileMapNode = SKTileMapNode(tileSet: tileMap.tileSet,
                                                         columns: Int(tileMap.size.width),
                                                         rows: Int(tileMap.size.height),
                                                         tileSize: tileMap.tileSize)
        
        layer.tiles.enumerated().forEach { y, tileRow in
            tileRow.enumerated().forEach { x, tile in
                if let tileGroup = tileMap.tileSet.tileGroups.first(where: { $0.name == tile }) {
                    #if os(macOS)
                    skTileMapNode.setTileGroup(tileGroup, forColumn: x, row: Int(tileMap.size.height) - y - 1)
                    #else
                    skTileMapNode.setTileGroup(tileGroup, forColumn: x, row: y)
                    #endif
                }
            }
        }
        
        return skTileMapNode
    }
    
    private func skSpriteNode(from object: TileMapObject, tileMap: TileMap) -> SKSpriteNode {
        let objectNode: SKSpriteNode = SKSpriteNode(color: .clear, size: object.size)
        #if os(macOS)
        let objectNodePosition: CGPoint = CGPoint(x: object.position.x + object.size.width * objectNode.anchorPoint.x - size.width * objectNode.anchorPoint.x,
                                                  y: object.position.y + object.size.height * objectNode.anchorPoint.y - size.height * objectNode.anchorPoint.y - size.height + object.size.height)
        #else
        let objectNodePosition: CGPoint = CGPoint(x: object.position.x + object.size.width * objectNode.anchorPoint.x - size.width * objectNode.anchorPoint.x,
                                                  y: object.position.y + object.size.height * objectNode.anchorPoint.y - size.height * objectNode.anchorPoint.y)
        #endif
        objectNode.position = objectNodePosition
        return objectNode
    }
    
}
