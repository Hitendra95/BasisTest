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
        card.backgroundColor = UIColor(red: 226/255, green: 243/255, blue: 243/255, alpha: 1)
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowOffset = .zero
        card.layer.shadowRadius = 10
        card.layer.borderWidth = 0.8
        card.layer.cornerRadius = 6
        card.clipsToBounds = true
        card.layer.masksToBounds = true
        return card
    }()
    
    let Text : UILabel = {
        
       let lb = UILabel()
        lb.text = ""
        lb.textColor = .black
        lb.textAlignment = .justified
        lb.font = UIFont(name: "Helvetica", size: 15)//UIFont.boldSystemFont(ofSize: 12)
        lb.numberOfLines = 0
        lb.backgroundColor = .clear
        return lb
    }()
    
    let Tracklabel : UILabel = {
        
       let lb = UILabel()
        lb.text = ""
        lb.textColor = .black
        lb.font = UIFont(name: "Helvetica-Bold", size: 15)
        lb.backgroundColor = .clear
        return lb
    }()
    
    //MARK: Add views
    override init(frame: CGRect) {
        super.init(frame: frame)
        CardFrameView.addSubview(Tracklabel)
        CardFrameView.addSubview(Text)
        addSubview(CardFrameView)
        addConstraints()
    }
    
    //MARK: Add constraints
    fileprivate func addConstraints() {
        CardFrameView.setAnchors(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        Tracklabel.setAnchors(top: CardFrameView.topAnchor, left: nil, bottom: nil, right: CardFrameView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, height: 22, width: 0)
        Text.setAnchors(top: CardFrameView.topAnchor, left: CardFrameView.leftAnchor, bottom: CardFrameView.bottomAnchor, right: CardFrameView.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 50, paddingRight: 20, height: 0, width: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
