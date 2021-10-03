//
//  GradientButton.swift
//  Evocatus
//
//  Created by Boris Sobolev on 02.10.2021.
//

import UIKit
class GradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        //l.frame = self.bounds
        l.colors = [UIColor(named: "main")?.cgColor, UIColor(named: "text2")?.cgColor, ]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        //l.cornerRadius = frame.height / 2
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
