//
//  MapParser.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation

/// A protocol that represent an object capable of parsing a `TileMap`.
protocol MapParser {
    
    /// Parse a tile map.
    /// - Parameter completion: a completion handler called at the end of the parsing.
    func parseMap(_ completion: @escaping (_ map: TileMap?) -> Void)
    
}
