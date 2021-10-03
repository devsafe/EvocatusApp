//
//  FiltersViewController.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import UIKit
import SnapKit

class FiltersViewController: UIViewController {
    private lazy var titleBackgroundView: UIView = {
        let titleBackgroundView = UIView()
        return titleBackgroundView
    }()

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonDidPress), for: .touchUpInside)
        return closeButton
    }()

    private lazy var saveButton: UIButton = {
        let button = PrimaryButton.make()
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.isHidden = true
        return picker
    }()

    private var selectedFilterItem: FilterItem.Kind?
    private var selectedDateItem: DateSelectorItem.Kind?
    private let saveHandler: (FilterItem.Kind?, DateSelectorItem.Kind?) -> Void

    private lazy var scrollView: UIScrollView = {
        return .init()
    }()

    private lazy var categoryItemsView: FIlterItemsView = {
        let fIlterItemsView = FIlterItemsView()
        fIlterItemsView.configure(
            items: [
                FilterItem(kind: .lunch),
                FilterItem(kind: .sport),
                FilterItem(kind: .party),
                FilterItem(kind: .board_games),
                FilterItem(kind: .nature)
            ],
            preselection: preselectedFilterItem.flatMap(FilterItem.init(kind:))
        )
        fIlterItemsView.selectItemHandler = { [weak self] item in
            if let filterItem = item as? FilterItem {
                self?.selectedFilterItem = filterItem.kind
            }
        }
        return fIlterItemsView
    }()

    private lazy var dataItemsView: FIlterItemsView = {
        let dataItemsView = FIlterItemsView()
        dataItemsView.configure(
            items: [
                DateSelectorItem(kind: .today),
                DateSelectorItem(kind: .tomorrow),
                DateSelectorItem(kind: .thisWeek)
            ],
            preselection: preselectedDateItem.flatMap(DateSelectorItem.init(kind:))
        )
        dataItemsView.selectItemHandler = { [weak self] item in
            if let dateSelectorItem = item as? DateSelectorItem {
                self?.selectedDateItem = dateSelectorItem.kind
            }
        }
        return dataItemsView
    }()

    private lazy var calendarButton: UIButton = {
        let calendarButton = UIButton()
        calendarButton.setImage(UIImage(named: "calendar"), for: .normal)
        calendarButton.setTitle("  Календарь", for: .normal)
        calendarButton.addTarget(self, action: #selector(calendarButtonButtonDidPress), for: .touchUpInside)
        return calendarButton
    }()

    let preselectedFilterItem: FilterItem.Kind?
    let preselectedDateItem: DateSelectorItem.Kind?

    init(
        preselectedFilterItem: FilterItem.Kind?,
        preselectedDateItem: DateSelectorItem.Kind?,
        saveHandler: @escaping (FilterItem.Kind?, DateSelectorItem.Kind?) -> Void
    ) {
        self.preselectedFilterItem = preselectedFilterItem
        self.preselectedDateItem = preselectedDateItem
        self.saveHandler = saveHandler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Фильтры"
        setupView()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        categoryItemsView.snp.remakeConstraints { make in
            make.height.equalTo(categoryItemsView.intrinsicContentSize.height)
        }

        dataItemsView.snp.remakeConstraints { make in
            make.height.equalTo(dataItemsView.intrinsicContentSize.height)
        }
    }

    @objc private func savePressed() {
        saveHandler(selectedFilterItem, selectedDateItem)
        self.dismiss(animated: true)
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "background")
        titleBackgroundView.backgroundColor = .white
        calendarButton.backgroundColor = .white
        calendarButton.layer.cornerRadius = 16
        calendarButton.setTitleColor(.black, for: .normal)


        view.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(closeButton)
        titleBackgroundView.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(createSectionLabel(title: "Категория"))
        stackView.addArrangedSubview(categoryItemsView)
        stackView.addArrangedSubview(createSectionLabel(title: "Дата"))
        stackView.addArrangedSubview(dataItemsView)
        stackView.addArrangedSubview(calendarButton)
        stackView.addArrangedSubview(datePicker)
        view.addSubview(saveButton)
    }

    private func setupLayout() {
        titleBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(4)
            make.size.equalTo(44)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleBackgroundView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).inset(-16)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.trailing.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(16)
        }

        calendarButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }

        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    private func createSectionLabel(title: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(named: "text2")
        label.text = title
        return label
    }

    @objc private func closeButtonDidPress() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func calendarButtonButtonDidPress() {
        datePicker.isHidden.toggle()
    }
}
