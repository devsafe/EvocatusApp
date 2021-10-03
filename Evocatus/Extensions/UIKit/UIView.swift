//
//  UIView.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import UIKit

extension UIView {
    @discardableResult func addSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { view in
            self.addSubview(view)
        }
        return self
    }
}
