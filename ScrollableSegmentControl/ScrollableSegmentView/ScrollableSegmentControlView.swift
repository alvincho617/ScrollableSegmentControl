//
//  ScrollableSegmentControlView.swift
//  ScrollableSegmentControl
//
//  Created by George Churikov on 14.03.2024.
//

import Foundation
import UIKit
import SnapKit

final class ScrollableSegmentControlView: UIView {
    
    // MARK: - UI elements
    
    public var segmenControl: UISegmentedControl
    private let scrollView = UIScrollView()

    // MARK: - Initializers

    convenience init(items: [Any]) {
        self.init(frame: .zero)
        self.segmenControl = ScrollableSegmentControl(items: items)
        setupViews()
    }
 
    override init(frame: CGRect) {
        segmenControl = UISegmentedControl()
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func setDataType(_ type: SegmentDataType) {
        switch type {
        case .customSegment(let segment):
            setCustomSegment(segmentControl: segment)
        case .items(let items):
            setItems(items: items)
        }
    }
    
    // MARK: - Privete methods
    
    // MARK: - Set data

    private func setItems(items: [Any]) {
        removeSubviews()
        segmenControl = ScrollableSegmentControl(items: items)
        setupViews()
    }
    
    private func setCustomSegment(segmentControl: ScrollableSegmentControl) {
        removeSubviews()
        self.segmenControl = segmentControl
        setupViews()
    }
    
    // MARK: - Setup views

    private func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func setupViews() {
        setupScrollView()
        setupSegmentControl()
    }

    private func setupScrollView() {
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges
                .equalToSuperview()
            make.height
                .equalToSuperview()
        }
    }
    
    private func setupSegmentControl() {
        scrollView.addSubview(segmenControl)
        segmenControl.snp.makeConstraints { make in
            make.edges
                .equalToSuperview()
            make.height
                .equalToSuperview()
            make.width
                .greaterThanOrEqualTo(scrollView.snp.width)
        }
        
        segmenControl.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)

    }
    
    @objc func segconChanged(segcon: UISegmentedControl) {
           let selectedSegmentIndex = segcon.selectedSegmentIndex
           let segmentWidth = segmenControl.frame.width / CGFloat(segmenControl.numberOfSegments)
           let targetOffsetX = segmentWidth * CGFloat(selectedSegmentIndex) - (scrollView.frame.width - segmentWidth) / 2

           let adjustedOffsetX = max(0, min(targetOffsetX, scrollView.contentSize.width - scrollView.frame.width))
           scrollView.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
       }
}

extension ScrollableSegmentControlView {
    enum SegmentDataType {
        case customSegment(_ segment: ScrollableSegmentControl)
        case items(_ items: [Any])
    }
}

