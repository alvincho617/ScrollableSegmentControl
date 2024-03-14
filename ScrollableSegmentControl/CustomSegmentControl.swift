//
//  CustomSegmentControl.swift
//  ScrollableSegmentControl
//
//  Created by George Churikov on 14.03.2024.
//

import UIKit

final class CustomSegmentControl: ScrollableSegmentControl {

    private(set) lazy var radius: CGFloat = 2.0
    
    /// Configure selected segment inset, can't be zero or size will error when click segment
    private var segmentInset: CGFloat = 0.1 {
        didSet{
            if segmentInset == 0 {
                segmentInset = 0.1
            }
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white.withAlphaComponent(0.2)
        setupTitleAttributes()
        makeSelectedItem()
        
        //MARK: - Configure Background Radius
        
        self.layer.cornerRadius = self.radius

    }
    
    private func setupTitleAttributes() {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        setTitleTextAttributes(titleTextAttributes, for: .normal)
        setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    private func makeSelectedItem() {
        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView
        {
            //MARK: - Configure selectedImageView Color
            selectedImageView.backgroundColor = .baseSegmentSelected
            selectedImageView.image = nil
            
            //MARK: - Configure selectedImageView Inset with SegmentControl
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset + 6, dy: segmentInset + 6)
            
            //MARK: - Configure selectedImageView cornerRadius
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = self.radius
            
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }
    
}
