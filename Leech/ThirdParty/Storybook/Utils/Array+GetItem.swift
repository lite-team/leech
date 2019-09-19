//
//  Copyright © 2019 Carousell. All rights reserved.
//

import Foundation

extension Array {
    func getItem(at index: Int) -> Element? {
        guard 0..<count ~= index else { return nil }
        return self[index]
    }
}
