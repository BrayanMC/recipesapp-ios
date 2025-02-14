//
//  String+Extensions.swift
//  UIComponents
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import UIKit

extension String {
    
    public var localized: String {
        NSLocalizedString(self, comment: self)
    }
    
    public func hasEmoticon() -> Bool {
        return self.containsEmoji
    }
    
    public var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, /// Emoticons
                0x1F300...0x1F5FF, /// Misc Symbols and Pictographs
                0x1F680...0x1F6FF, /// Transport and Map
                0x2600...0x26FF, /// Misc symbols
                0x2700...0x27BF, /// Dingbats
                0xFE00...0xFE0F, /// Variation Selectors
                0x1F900...0x1F9FF, /// Supplemental Symbols and Pictographs
                0x1F1E6...0x1F1FF,
                127000...127600, /// Various asian characters
                65024...65039, /// Variation selector
                9100...9300, /// Misc items
                8400...8447: /// Flags
                return true
            default:
                continue
            }
        }
        return false
    }
}
