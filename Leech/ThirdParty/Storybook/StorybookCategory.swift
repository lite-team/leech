//
//  Copyright © 2019 Carousell. All rights reserved.
//

import Foundation

public struct StorybookCategory {
    public let title: String
    public let items: [StorybookItem]

    public init(title: String, items: [StorybookItem]) {
        self.title = title
        self.items = items
    }
}
