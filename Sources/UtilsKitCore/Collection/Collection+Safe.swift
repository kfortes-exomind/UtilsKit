//
//  Collection+Safe.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

public extension Collection {
	
	/**
	 
	 Return the element at given index if exists, otherwise returns nil.
	 
	 - parameter index: the index to get element with.
	 
	 - returns: element of collection with given index or nil.
	 
	 */
	subscript (safe index: Index) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}
