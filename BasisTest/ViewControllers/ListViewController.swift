//
//  ListViewController.swift
//  BasisTest
//
//  Created by Hitendra Dubey on 26/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var list : [ListData]?
    let button = UIButton()
    var currentIndex = 0
    var divisor: CGFloat!
    
    public var cardOversize: CGFloat = 6
    public var cardSideWith : CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        makeReloadButton()
        GetList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         // to register the view
         BaseModel.sharedInstanceBaseModel.registerView(notifier: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // to unregister the view
        BaseModel.sharedInstanceBaseModel.unregisterView(notifier: self)
    }
    
    //MARK: Set Background and divisio calculation
    func setUpView()
    {
          //0.61 is the value of 30% in radian
          divisor = (view.frame.width/2)/0.61
          view.backgroundColor = UIColor.lightGray
    }
    
    //MARK: Make Reload Button
    func makeReloadButton()
    {
        button.setTitle("Reload", for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(reload), for: .touchDown)
        button.setAnchors(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, height: 50, width: 100)
    }
    
    
    //MARK: Make View After getting data
    func makeView()
    {
        currentIndex = 0
        guard let lis = list else {return}
        let count = lis.count
        var i = count
        while i > 0
        {
            let card = getView(viewModel: lis[i-1], totalCardCount: "\(count)")
            self.view.addSubview(card)
            card.tag = i
            currentIndex = i
            card.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(collectionTapped(_:))))
            card.setAnchors(top: nil, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 22-(CGFloat(CGFloat((count-i))*cardSideWith)), paddingBottom: 0, paddingRight: 22-(CGFloat(CGFloat((count-i))*cardSideWith)), height: 500, width: 0)
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat((i))*cardOversize).isActive = true
            i -= 1
        }
    }
    
    //MARK: Reload button function
    @objc func reload(){
        view.subviews.forEach({ $0.removeFromSuperview() })
        makeView()
    }
    
    func update()
    {

    }
    
    //MARK: Get Custom View
    func getView(viewModel: ListData,totalCardCount: String)-> UIView{
        
        let card = CustomCardView()
        card.Text.text = viewModel.text
        card.Tracklabel.text = (viewModel.id ?? "")+"/"+totalCardCount
        return card
    }
    
}

//MARK: Handle all animation part
extension ListViewController{
    
    @objc func collectionTapped(_ sender: UIPanGestureRecognizer)
    {
        guard let card = sender.view else {return}
        guard let count = list?.count else {return}
        let point = sender.translation(in: view)
        
        //Get center to Handle animation
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x+point.x, y: view.center.y+point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        // handle when gesture ended
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
                    card.center.y = (self.view.center.y+CGFloat(CGFloat((count-card.tag))*self.cardOversize))
                    card.transform = .identity
                }
            }
        }
    }
}

//MAKR: Handle network calls
extension ListViewController:UpdateViewProtocol{
    
    
    //MARK: GET List From Server
     func GetList() {
         
         EventsController.sharedInstanceAppController.handleEvent(eventid: NetworkEvents.EVENT_GET_LIST)
         
     }
    
    //MARK: Handle update Notify from handlers
    func updateView(event: Int, eventtype: Int) {
        
        switch event {
            case NetworkEvents.EVENT_GET_LIST:
                switch eventtype{
                    case ConnectionModel.EVENT_TYPE_SUCCESS:
                        guard let response = ModelFacade.sharedInstanceModelFacade.getListModel().list.data else {return}
                        self.list = response
                        self.makeView()
                    case ConnectionModel.EVENT_TYPE_ERROR:
                        displayAlert(message: Constants.ERROR)
        
                    case ConnectionModel.EVENT_TYPE_NETWORKERROR:
                        displayAlert(message: Constants.ERROR_NETWORK_ERROR)
                    default:
                        print("default block")
                    }
            default:
                print("default block")
        
        }
    }
    
    //MARK: Show ALert
    func displayAlert(message:String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            
        alert.view.clipsToBounds = true
        alert.view.sizeToFit()
            
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
