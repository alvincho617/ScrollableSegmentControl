//
//  ScrollableSegmentControl.swift
//  ScrollableSegmentControl
//
//  Created by George Churikov on 14.03.2024.
//

import UIKit

class ScrollableSegmentControl: UISegmentedControl {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
