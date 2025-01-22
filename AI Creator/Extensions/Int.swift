//
//  Int.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

extension Int {
    func formattedWithSuffix() -> String {
        switch self {
        case 1_000_000...:
            return String(format: "%.1fM", Double(self) / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 10_000...:
            return String(format: "%.1fK", Double(self) / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return "\(self)"
        }
    }
}
