//
//  FilterItem.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import UIKit

protocol FilterItemViewItem {
    var image: UIImage? { get }
    var title: String { get }
}

struct DateSelectorItem: FilterItemViewItem {
    let image: UIImage? = nil
    var title: String { kind.title }

    enum Kind {
        case today
        case tomorrow
        case thisWeek

        var title: String {
            switch self {
            case .today:
                return "Сегодня"
            case .tomorrow:
                return "Завтра"
            case .thisWeek:
                return "Эта неделя"
            }
        }
    }

    let kind: Kind
}

struct FilterItem: FilterItemViewItem {

    var image: UIImage? { kind.image }
    var title: String { kind.title }

    enum Kind: String, Decodable {
        case sport
        case lunch
        case party
        case board_games
        case nature

        var image: UIImage? {
            switch self {
            case .sport:
                return UIImage(named: "filter_sport")
            case .lunch:
                return UIImage(named: "filter_breakfast")
            case .party:
                return UIImage(named: "filter_party")
            case .board_games:
                return UIImage(named: "filter_boardgames")
            case .nature:
                return UIImage(named: "filter_nature")
            }
        }

        var title: String {
            switch self {
            case .sport:
                return "Спорт"
            case .lunch:
                return "Обед"
            case .party:
                return "Туса"
            case .board_games:
                return "Настолки"
            case .nature:
                return "Природа"
            }
        }
    }

    let kind: Kind
}
