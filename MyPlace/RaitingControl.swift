//
//  RaitingControl.swift
//  MyPlace
//
//  Created by Mitya Kim on 01.11.2020.
//

import UIKit

@IBDesignable class RaitingControl: UIStackView {
    
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
    
    
    var rating = 0
    
    

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
        print("Button pressed")
        
    }
    
    private func setupButtons() {
        
        for button in raitingButton {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        raitingButton.removeAll()
        
        for i in 0..<starCount {
            
            
            
            let button = UIButton()
            button.backgroundColor = .blue
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.addTarget(self, action: #selector(raitingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            raitingButton.append(button)
            
        }
        
        
        
    }

}
