//
//  Sequence+Same.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

public extension Sequence where Element: Equatable {
	
	/// Check if two sequence has same elements
	func isSame(array: any Sequence<Element>) -> Bool {
		self.containsAll(array) && array.containsAll(self)
	}
}
