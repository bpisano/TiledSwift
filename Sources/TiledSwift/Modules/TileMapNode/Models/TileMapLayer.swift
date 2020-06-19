//
//  TileMapLayer.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 18/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation
import CoreGraphics

/// An abstract struct that represents a layers of the tile map.
public struct TileMapLayer {
    
    let id: String
    let name: String
    let size: CGSize
    let tiles: [[String]]

}
