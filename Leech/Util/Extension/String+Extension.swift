//
//  String+Extension.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/1/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

infix operator +++
extension String {
    public static func +++(left: String, right: String) -> String {
        return (left as NSString).appendingPathComponent(right)
    }
}
