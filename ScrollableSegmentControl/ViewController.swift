//
//  ViewController.swift
//  ScrollableSegmentControl
//
//  Created by George Churikov on 14.03.2024.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    private let items = ["Chats", "Unread", "Personal", "Bots", "Photos", "Private", "Archive"]
    
    private lazy var scrollableSegmentControlView = ScrollableSegmentControlView(items: items)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baseBackground
        
        let customSegment = CustomSegmentControl(items: items)
        
        scrollableSegmentControlView.setDataType(.customSegment(customSegment))
        // OR
        scrollableSegmentControlView.setDataType(.items(items))

        scrollableSegmentControlView.segmenControl.selectedSegmentIndex = 0
        
        setupSegmentControl()
    }
    
    private func setupSegmentControl() {
        view.addSubview(scrollableSegmentControlView)
        scrollableSegmentControlView.snp.makeConstraints { make in
            make.top
                .equalToSuperview()
                .offset(100)
            make.horizontalEdges
                .equalToSuperview()
                .inset(20)
        }
    }
    
}


