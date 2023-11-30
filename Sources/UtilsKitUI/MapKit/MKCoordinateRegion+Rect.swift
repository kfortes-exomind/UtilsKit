//
//  MKCoordinateRegion+Rect.swift
//
//
//  Created by Michael Coqueret on 30/11/2023.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
	
	/// Get rect from region
	public func getRect() -> MKMapRect {
		let topLeft = CLLocationCoordinate2D(latitude: self.center.latitude + (self.span.latitudeDelta / 2),
											 longitude: self.center.longitude - (self.span.longitudeDelta / 2))
		
		let bottomRight = CLLocationCoordinate2D(latitude: self.center.latitude - (self.span.latitudeDelta / 2),
												 longitude: self.center.longitude + (self.span.longitudeDelta / 2))
		
		let a = MKMapPoint(topLeft)
		let b = MKMapPoint(bottomRight)
		
		return MKMapRect(origin: MKMapPoint(x: min(a.x, b.x),
											y: min(a.y, b.y)),
						 size: MKMapSize(width: abs(a.x - b.x),
										 height: abs(a.y - b.y)))
	}
}
