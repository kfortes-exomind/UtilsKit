//
//  Double+Distance.swift
//  UtilsKit
//
//  Created by RGMC on 10/07/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)

import Foundation

extension Double {

    /**
    Self in distance with maximum fraction digits from meters to local measurement

    - parameter maximumFractionDigits : Maximum fraction digits. Default 1
    - parameter locale : Locale. Default current
    - parameter preventKmConversion : Prevent conversion to kilometers if true and value >= 1000. Default false
    - returns: The formated result

    ~~~
    let value = 1000
     print(value.toDistance()) // prints `1 km` in France, `0,6 mile` in US
     ~~~
     */
    public func toDistance(minimumFractionDigits: Int = 0,
                           maximumFractionDigits: Int = 0,
                           locale: Locale = Locale.current,
                           preventKmConversion: Bool = false) -> String {
        let nbFormatter = NumberFormatter()
        nbFormatter.minimumFractionDigits = minimumFractionDigits
        nbFormatter.maximumFractionDigits = maximumFractionDigits

        let formatter = MeasurementFormatter()
        formatter.locale = locale
        formatter.numberFormatter = nbFormatter
        if preventKmConversion && self >= 1000 {
            formatter.unitOptions = .providedUnit
        } else {
            formatter.unitOptions = .naturalScale
        }

        return formatter.string(from: Measurement(value: self, unit: UnitLength.meters))
    }
}

extension Int {

    /**
    Self in distance with maximum fraction digits from meters to local measurement

    - parameter maximumFractionDigits : Maximum fraction digits. Default 1
    - parameter locale : Locale. Default current
    - parameter preventKmConversion : Prevent conversion to kilometers if true and value >= 1000. Default false
    - returns: The formated result

    ~~~
    let value = 1000
    print(value.toDistance()) // prints `1 km` in France, `0,6 mile` in US
    ~~~
    */
    public func toDistance(minimumFractionDigits: Int = 0,
                           maximumFractionDigits: Int = 0,
                           locale: Locale = Locale.current,
                           preventKmConversion: Bool = false) -> String {
        Double(self).toDistance(minimumFractionDigits: minimumFractionDigits,
                                maximumFractionDigits: maximumFractionDigits,
                                locale: locale,
                                preventKmConversion: preventKmConversion)
    }
}

#endif
