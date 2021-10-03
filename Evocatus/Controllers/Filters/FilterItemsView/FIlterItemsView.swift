//
//  FIlterItemsView.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import UIKit

class FIlterItemsView: UIView {
    var selectItemHandler: ((FilterItemViewItem) -> Void)?

    private var items: [FilterItemViewItem] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            FilterItemCollectionCell.self,
            forCellWithReuseIdentifier: FilterItemCollectionCell.identifier
        )

        return collectionView
    }()

    override var intrinsicContentSize: CGSize {
        return collectionView.contentSize
    }

    init() {
        super.init(frame: .zero)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var preselection: FilterItemViewItem?

    func configure(items: [FilterItemViewItem], preselection: FilterItemViewItem?) {
        self.preselection = preselection
        self.items = items
        collectionView.reloadData()
    }

    private func setupView() {
        backgroundColor = UIColor(named: "background")
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
    }

    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FIlterItemsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterItemCollectionCell.identifier, for: indexPath) as! FilterItemCollectionCell
        cell.configure(filterItem: items[indexPath.row])
        if let preselection = preselection, items[indexPath.row].title == preselection.title {
            cell.isSelected = true
            self.preselection = nil
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterItemCollectionCell.identifier, for: indexPath) as! FilterItemCollectionCell
        cell.isSelected = true
        selectItemHandler?(items[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterItemCollectionCell.identifier, for: indexPath) as! FilterItemCollectionCell
        cell.isSelected = false
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: FilterItemCollectionCell.width(for: items[indexPath.row]), height: 44)
    }
}
