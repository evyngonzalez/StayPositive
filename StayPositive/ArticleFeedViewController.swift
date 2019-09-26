//
//  ArticleFeedViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 8/28/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit

class ArticleFeedViewController: UIViewController, XMLParserDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var xmlParser: XMLParser!
    var currentElement = ""
    var foundCharacters = ""
    var currentData = [String: String]()
    var parsedData = [[String: String]]()
    var isHeader = true
    
    func startParsingWithContentsOfURL(rssURL: URL, with completion: (Bool)->()) {
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        if let flag = parser?.parse() {
            parsedData.append(currentData)
            completion(flag)
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" || currentElement == "entry" {
            
            if isHeader == false {
                parsedData.append(currentData)
            }
            isHeader = false
        }
        if isHeader == false {
            if currentElement == "media:thumbnail" || currentElement == "media:content" {
                foundCharacters += attributeDict["url"]!
            }
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isHeader == false {
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "content" || currentElement == "pubDate" || currentElement == "author" || currentElement == "dc:creator" || currentElement == "content:encoded"{
                foundCharacters += string
//                foundCharacters.deleteHTML(tags: ["a", "p", "div", "img"])
            }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }

}
