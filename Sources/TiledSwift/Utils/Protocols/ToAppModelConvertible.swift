//
//  ToAppModelConvertible.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 18/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation

protocol ToAppModelConvertible {
    
    associatedtype AppModelType
    
    func toAppModel() -> AppModelType?

}
