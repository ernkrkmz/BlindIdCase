//
//  String+Extension.swift
//  BlindidCase
//
//  Created by Eren Korkmaz on 23.05.2025.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoFormatter.date(from: self) else {
            return self
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}

