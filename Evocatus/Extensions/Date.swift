//
//  NewEvents.swift
//  Evocatus
//
//  Created by Boris Sobolev on 03.10.2021.
//

import Foundation

extension String {
    var iso8601Date: Date {
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime]
        return iso8601DateFormatter.date(from: self)!
    }
}

extension Date {
    var isoString: String {
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime]
        return iso8601DateFormatter.string(from: self)
    }

    var fullDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd.MM  hh:mm"
        return dateFormatter.string(from: self)
    }

    var hhmmString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self)
    }
}
