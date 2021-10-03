//
//  PrimaryButton.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import UIKit

enum PrimaryButton {
    static func make(title: String = "Применить") -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "main")
        button.layer.cornerRadius = 16
        return button
    }
}
