//
//  Copyright © 2019 Carousell. All rights reserved.
//

import Foundation

public struct StorybookItem {
    public let title: String
    public let classType: LayoutTestable.Type

    public init(title: String, classType: LayoutTestable.Type) {
        self.title = title
        self.classType = classType
    }

    public init(classType: LayoutTestable.Type) {
        let title = "\(classType.self)"
        self.init(title: title, classType: classType)
    }
}
