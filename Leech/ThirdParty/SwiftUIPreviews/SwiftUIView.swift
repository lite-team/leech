//
//  Copyright © 2019 Nghia. All rights reserved.
//

#if canImport(SwiftUI)
import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct SwiftUIView<T: UIView>: UIViewRepresentable {
    public let wrapped: T

    public init(view: T) {
        self.wrapped = view
    }

    public func updateUIView(_ uiView: T, context: UIViewRepresentableContext<SwiftUIView<T>>) {
    }

    public func makeUIView(context: UIViewRepresentableContext<SwiftUIView<T>>) -> T {
        return wrapped
    }
}
#endif
