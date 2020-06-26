//
//  ListViewController.swift
//  BasisTest
//
//  Created by Hitendra Dubey on 26/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    let data = [1,2,3,4,5,6]
    let button = UIButton()
    var collection = [UIView]()
    var currentIndex = 0
    var topCard : UIView?
    public var cardOversize: CGFloat = 6
    public var cardSideWith : CGFloat = 2
    var divisor: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width/2)/0.61
        makeView()

        // Do any additional setup after loading the view.
    }
    
    func makeView()
    {
        currentIndex = 0
        collection.removeAll()
        
        button.setTitle("Reload", for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(reload), for: .touchDown)
        button.setAnchors(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, height: 50, width: 100)
        for i in 1 ... data.count
        {
            view.backgroundColor = UIColor.lightGray
            
            let card = UIView()
            card.backgroundColor = .white
            card.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(collectionTapped(_:))))
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOpacity = 1
            card.layer.shadowOffset = .zero
            card.layer.shadowRadius = 10
            card.layer.borderWidth = 0.4
            card.layer.masksToBounds = true
            collection.append(card)
            self.view.addSubview(card)
            card.tag = i
            currentIndex = i
            card.setAnchors(top: nil, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 22-(CGFloat(CGFloat((i))*cardSideWith)), paddingBottom: 0, paddingRight: 22-(CGFloat(CGFloat((i))*cardSideWith)), height: 500, width: 0)
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat((data.count-i))*cardOversize).isActive = true
        }
    }
    
    @objc func reload(){
        view.subviews.forEach({ $0.removeFromSuperview() })
        makeView()
    }
    
    @objc func collectionTapped(_ sender: UIPanGestureRecognizer)
    {
        guard let card = sender.view else {return}
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x+point.x, y: view.center.y+point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        if sender.state == UIGestureRecognizer.State.ended{
            
            if card.center.x+25 < view.frame.width/2{
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: card.center.x - self.view.frame.width, y: card.center.y+75)
                }
                card.removeFromSuperview()
                update()
                return
            }else if card.center.x-25 > view.frame.width/2{
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: card.center.x + self.view.frame.width, y: card.center.y+75)
                }
                card.removeFromSuperview()
                update()
                return
            }
            else
            {
                UIView.animate(withDuration: 0.2) {
                    card.center.x = self.view.center.x
                    card.center.y = (self.view.center.y+CGFloat(CGFloat((self.data.count-card.tag))*self.cardOversize))
                    card.transform = .identity
                }
            }
        }
    }
    
    func update()
    {

    }
    
    

}

