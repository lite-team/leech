//
//  File.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/19/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

public struct SmallEdge: Edgeable {
    public static var edge: CGFloat { return C.Spacing.small }
}

public struct MediumEdge: Edgeable {
    public static var edge: CGFloat { return C.Spacing.medium }
}

public struct LargeEdge: Edgeable {
    public static var edge: CGFloat { return C.Spacing.large }
}

public struct ExtraLarge: Edgeable {
    public static var edge: CGFloat { return C.Spacing.extraLarge }
}

public struct HugeEdge: Edgeable {
    public static var edge: CGFloat { return C.Spacing.huge }
}

