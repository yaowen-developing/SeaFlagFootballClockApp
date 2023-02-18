//
//  Extensions.swift
//  ClockApp
//
//  Created by Yaowen Wang on 2/17/23.
//

import Foundation

extension Decimal {
    func rounded(_ roundingMode: NSDecimalNumber.RoundingMode = .plain) -> Int {
        var result = Decimal()
        var number = self
        NSDecimalRound(&result, &number, 0, roundingMode)
        return (result as NSDecimalNumber).intValue
    }
    var int: Int { rounded(sign == .minus ? .up : .down) }
    var fraction: Decimal { self - Decimal(int) }
}
