// NSConstraint+setPriorityFunc.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Добавляет возможность установки приоритета через краткий синтаксис. Пример:
/// meetingFormView.widthAnchor.constraint(lessThanOrEqualToConstant: 300).withPriority(500),
extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
