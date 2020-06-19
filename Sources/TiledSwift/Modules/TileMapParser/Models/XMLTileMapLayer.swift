//
//  XMLTileMapLayer.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation
import CoreGraphics

internal struct XMLTileMapLayer {
    
    let id: String
    let name: String
    let layerSize: CGSize
    var data: String?

}

extension XMLTileMapLayer: XMLDecodable {
    
    static func decode(attributes: [String : String]) -> XMLTileMapLayer? {
        guard let id = attributes["id"] else { return nil }
        guard let name = attributes["name"] else { return nil }
        guard let layerSize = size(fromAttributes: attributes) else { return nil }
        return XMLTileMapLayer(id: id, name: name, layerSize: layerSize, data: nil)
    }
    
}

extension XMLTileMapLayer: ToAppModelConvertible {
    
    func toAppModel() -> TileMapLayer? {
        guard let data = data else { return nil }
        let tiles: [[String]] = data.replacingOccurrences(of: "\n", with: "")
            .split(separator: ",")
            .map({ String($0) })
            .chunked(into: Int(layerSize.width))
        return TileMapLayer(id: id,
                            name: name,
                            size: layerSize,
                            tiles: tiles)
    }
    
}
