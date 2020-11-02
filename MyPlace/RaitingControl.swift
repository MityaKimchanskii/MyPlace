//
//  RaitingControl.swift
//  MyPlace
//
//  Created by Mitya Kim on 01.11.2020.
//

import UIKit

@IBDesignable class RaitingControl: UIStackView {
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    private var raitingButton = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44, height: 44) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func raitingButtonTapped(button: UIButton) {
        
        guard let index = raitingButton.firstIndex(of: button) else { return }
        
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    private func setupButtons() {
        
        for button in raitingButton {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        raitingButton.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        

        for _ in 0..<starCount {
            
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.addTarget(self, action: #selector(raitingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            raitingButton.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in raitingButton.enumerated() {
            button.isSelected = index < rating
        }
    }
}
