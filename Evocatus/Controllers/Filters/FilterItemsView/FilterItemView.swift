//
//  FilterItemView.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import UIKit

class FilterItemView: UIView {
    private var _isSelected: Bool = false

    var isSelected: Bool {
        set {
            backgroundColor = newValue ? UIColor(named: "purple") : .white
            titleLabel.textColor = newValue ? .white : .black
            _isSelected = newValue
        }
        get {
            _isSelected
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()

    init() {
        super.init(frame: .zero)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(filterItem: FilterItemViewItem) {
        imageView.image = filterItem.image
        titleLabel.text = filterItem.title
        imageView.isHidden = filterItem.image == nil
    }

    private func setupView() {
        layer.cornerRadius = 16
        backgroundColor = .white
        titleLabel.textColor = .black

        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
    }

    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(14)
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }

    static func width(for item: FilterItemViewItem) -> CGFloat {
        var width: CGFloat = 0
        width += item.image == nil ? 0 : 24
        width += 14 + 14
        width += item.image == nil ? 0 : 6
        width += 1
        width += item.title.size().width
        return width
    }
}


extension String {
    func size(OfFont font: UIFont = .systemFont(ofSize: 17)) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
