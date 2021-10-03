//
//  MeetsTableViewCell.swift
//  Evocatus
//
//  Created by Boris Sobolev on 02.10.2021.
//

import UIKit
import SnapKit
import Kingfisher

extension MeetsTableViewCell {

    final class LabelWithImage: UIView {

        private lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .clear
            return imageView
        }()

        private lazy var title: UILabel = {
            let label = UILabel()
            label.textColor = .black.withAlphaComponent(0.7)
            label.font = UIFont.systemFont(ofSize: 15)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.7
            label.textAlignment = .left
            return label
        }()

        init() {
            super.init(frame: .zero)
            setupSubviews()
            setupLayout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupSubviews() {
            addSubviews(
                imageView,
                title
            )
        }

        private func setupLayout() {
            imageView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.size.equalTo(16)
            }
            title.snp.makeConstraints { make in
                make.trailing.equalToSuperview()
                make.centerY.equalTo(imageView.snp.centerY)
                make.leading.equalTo(imageView.snp.trailing).inset(-6)
            }
        }

        func configure(image: UIImage, title: String) {
            self.title.text = title
            self.imageView.image = image
        }
    }
}

class MeetsTableViewCell: UITableViewCell {
    
    static let identifier = "MeetsTableViewCellReuseIndentifier"

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private lazy var VStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 6
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .left
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var insetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    private var buttonHandler: (() -> Void)?

    private lazy var labelLocation: LabelWithImage = {
        LabelWithImage()
    }()

    private lazy var labelTime: LabelWithImage = {
        LabelWithImage()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.addSubviews(
            insetView.addSubviews(
                logoImageView,
                VStack,
                actionButton
            )
        )
        VStack.addArrangedSubview(titleLabel)
        VStack.addArrangedSubview(labelLocation)
        VStack.addArrangedSubview(labelTime)

        backgroundColor = .clear
        selectionStyle = .none

        setupLayout()
    }

    private func setupLayout() {
        insetView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(6)
        }
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
            make.size.equalTo(60)
        }
        VStack.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).inset(-16)
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.trailing.equalTo(actionButton.snp.leading).inset(-6)
        }
        VStack.arrangedSubviews.forEach { view in
            view.snp.makeConstraints { make in
                make.width.equalTo(VStack.snp.width)
            }
        }
        actionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
            make.size.equalTo(26)
        }
    }

    @objc private func buttonPressed() {
        buttonHandler?()
    }
    
    func configure(
        event: Event,
        isChecked: Bool,
        buttonHandler: @escaping () -> Void
    ) {
        self.buttonHandler = buttonHandler
        titleLabel.text = event.name
        if let url = event.photoURL {
            logoImageView.kf.setImage(with: URL(string: url)!)
        }
        actionButton.setImage(UIImage(named: isChecked ? "icon_check" : "icon_close"), for: .normal)
        labelLocation.configure(
            image: UIImage(named: "local")!,
            title: event.place
        )
        labelTime.configure(
            image: UIImage(named: "clock")!,
            title: isChecked
            ? event.dttm.iso8601Date.hhmmString
            : event.dttm.iso8601Date.fullDateString
        )
    }
}
