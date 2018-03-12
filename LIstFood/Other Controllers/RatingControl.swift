//
//  RatingControl.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/10/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize : CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButton()
        }
    }
    @IBInspectable var starCount : Int = 5 {
        didSet{
            setupButton()
        }
    }
    
    required init(coder : NSCoder){
        super.init(coder: coder)
        
        setupButton()
    }
    override init(frame : CGRect){
        super.init(frame: frame)
        
        setupButton()
    }
    
    
    @objc func rateButtonTapped(button : UIButton) {
        guard let index = ratingButtons.index(of : button) else {
            fatalError("the button ,\(button) , is not in the rating buttons array :\(ratingButtons)")
        }
        
        let selectRating = index + 1
        
        if selectRating == rating {
            rating = 0
        }else {
            rating = selectRating
        }
    }
    
    private func setupButton(){
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highLightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
       
        for item in 0..<starCount {
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highLightedStar, for: .highlighted)
            button.setImage(highLightedStar, for: [.highlighted,.selected])
            
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            
            button.accessibilityLabel = "set \(item + 1) star rating"
            
            button.addTarget(self, action:
                #selector(RatingControl.rateButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            let hintString : String?
            
            if rating == index + 1 {
                hintString = "tap to reset rating zero"
            }else {
                hintString = nil
            }
            
            let valueString : String
            
            switch (rating){
            case 0 :
                valueString = "Not rating set"
            case 1 :
                 valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
}
