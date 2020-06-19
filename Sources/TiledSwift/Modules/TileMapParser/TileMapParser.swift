//
//  TileMapParser.swift
//  TilesetParser
//
//  Created by Benjamin Pisano on 17/06/2020.
//  Copyright © 2020 Snopia. All rights reserved.
//

import Foundation

/// A class used to parse a tile map from an XML file.
public final class TileMapParser: NSObject, MapParser {
    
    private let parser: XMLParser
    private var didFinishParsing: ((_ map: TileMap?) -> Void)?
    private var currentElement: ParsingElement = .none
    private var map: XMLTileMap?
    
    public init(fileNamed fileName: String, extension fileExtension: String = "tmx") throws {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { throw Error.noFileNamed(fileName: fileName, extension: fileExtension) }
        let fileData: Data = try Data(contentsOf: fileUrl)
        self.parser = XMLParser(data: fileData)
    }
    
    public func parseMap(_ completion: @escaping (_ map: TileMap?) -> Void) {
        didFinishParsing = completion
        parser.delegate = self
        parser.parse()
    }

}

extension TileMapParser: XMLParserDelegate {
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard let element =  ParsingElement(rawValue: elementName) else { return }
        switch element {
        case .map:
            map = XMLTileMap.decode(attributes: attributeDict)
        case .tileSet:
            if let decodedTileSet = XMLTileSet.decode(attributes: attributeDict) {
                map?.tileSets.append(decodedTileSet)
            }
        case .image:
            if let lastIndex = map?.tileSets.indices.upperBound {
                map?.tileSets[lastIndex - 1].image = attributeDict["source"]
            }
        case .layer:
            if let decodedLayer = XMLTileMapLayer.decode(attributes: attributeDict) {
                map?.layers.append(decodedLayer)
            }
        case .objectGroup:
            if let decodedObjectGroup = XMLTileMapObjectGroup.decode(attributes: attributeDict) {
                map?.objectGroups.append(decodedObjectGroup)
            }
        case .object:
            if let lastIndex = map?.objectGroups.indices.upperBound, let decodedObject = XMLTileMapObject.decode(attributes: attributeDict) {
                map?.objectGroups[lastIndex - 1].objects.append(decodedObject)
            }
        default:
            break
        }
        currentElement = element
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = .none
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case .data:
            if let lastIndex = map?.layers.indices.upperBound {
                map?.layers[lastIndex - 1].data = string
            }
        default:
            break
        }
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        didFinishParsing?(map?.toAppModel())
    }
    
}

extension TileMapParser {
    
    enum ParsingElement: String {
        
        case none
        case map
        case tileSet = "tileset"
        case image
        case layer
        case data
        case objectGroup = "objectgroup"
        case object
        
    }
    
}

extension TileMapParser {
    
    enum Error: Swift.Error {
        
        case noFileNamed(fileName: String, extension: String)
        
        var localizedDescription: String {
            switch self {
            case .noFileNamed(fileName: let fileName, extension: let fileExtension):
                return "No such file named \(fileName).\(fileExtension)"
            }
        }
        
    }
    
}
