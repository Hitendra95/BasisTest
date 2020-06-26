//
//  CustomView.swift
//  BasisTest
//
//  Created by Hitendra Dubey on 27/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import Foundation
import UIKit

class CustomCardView : UIView{
 
    let CardFrameView: UIView = {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowOffset = .zero
        card.layer.shadowRadius = 10
        card.layer.borderWidth = 0.4
        card.layer.masksToBounds = true
        return card
    }()
    
    let Text : UILabel = {
        
       let lb = UILabel()
        lb.text = ""
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.numberOfLines = 0
        lb.backgroundColor = .clear
        return lb
    }()
    
    let Tracklabel : UILabel = {
        
       let lb = UILabel()
        lb.text = ""
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.backgroundColor = .clear
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CardFrameView.addSubview(Tracklabel)
        CardFrameView.addSubview(Text)
        addSubview(CardFrameView)
        addConstraints()
    }
    
    fileprivate func addConstraints() {
        CardFrameView.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        Tracklabel.setAnchors(top: CardFrameView.topAnchor, left: nil, bottom: nil, right: CardFrameView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, height: 22, width: 0)
        Text.setAnchors(top: CardFrameView.topAnchor, left: CardFrameView.leftAnchor, bottom: CardFrameView.bottomAnchor, right: CardFrameView.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 50, paddingRight: 20, height: 0, width: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
