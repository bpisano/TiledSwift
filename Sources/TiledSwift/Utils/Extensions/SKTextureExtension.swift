//
//  SKTextureExtension.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 18/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import SpriteKit

internal extension SKTexture {
    
    /// Crop a texture with at a given origin and size.
    /// - Parameters:
    ///   - origin: the position to crop.
    ///   - sizeToCrop: the size to crop.
    /// - Returns: the cropped texture.
    func cropped(origin: CGPoint, size sizeToCrop: CGSize) -> SKTexture {
        let cropSize: CGSize = CGSize(width: sizeToCrop.width * textureRect().width / size().width,
                                      height: sizeToCrop.height * textureRect().height / size().height)
        #if os(macOS)
        let cropOrigin: CGPoint = CGPoint(x: origin.x / size().width  + textureRect().origin.x,
                                          y: 1 - (origin.y / size().height + textureRect().origin.y) - cropSize.height)
        #else
        let cropOrigin: CGPoint = CGPoint(x: origin.x / size().width  + textureRect().origin.x,
                                          y: origin.y / size().height + textureRect().origin.y)
        #endif
        let cropRect: CGRect = CGRect(origin: cropOrigin, size: cropSize)
        return SKTexture(rect: cropRect, in: self)
    }
    
}
