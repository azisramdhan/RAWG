//
//  Double.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}
