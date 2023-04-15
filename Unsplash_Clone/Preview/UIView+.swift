//
//  UIView+.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIView {
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
    
    func showPreview() -> some View {
        Preview(view: self)
            .previewDevice(
                PreviewDevice(rawValue: DeviceType.iPhone12ProMax.name())
            )
    }
}
#endif
