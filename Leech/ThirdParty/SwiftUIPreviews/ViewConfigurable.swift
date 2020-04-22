//
//  Copyright © 2019 Nghia. All rights reserved.
//

import UIKit

public protocol ViewConfigurable {
    associatedtype Model
    
    func configure(viewModel: Model)
}
