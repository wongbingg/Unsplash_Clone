//
//  UIViewController+.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType,
                                    context: Context) {
            //
        }
    }
    
    func showPreview(_ deviceType: DeviceType = .iPhone12ProMax) -> some View {
        Preview(viewController: self)
            .previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
