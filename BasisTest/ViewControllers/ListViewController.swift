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
    var currentIndex = 1
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
          divisor = (view.frame.width/2)/0.17 ///0.26 ///0.61
        view.backgroundColor = UIColor(red: 42/255, green: 101/255, blue: 99/255, alpha: 1)
    }
    
    //MARK: Make Reload Button
    func makeReloadButton()
    {
        button.setTitle("", for: .normal)
        let image = UIImage(named: "icons8-reset-100")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image?.withTintColor(.white), for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(reload), for: .touchDown)
        button.setAnchors(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, height: 35, width: 35)
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
            let swipeGetures = setupSwipeGestures(view: card)
            let panGesture = UIPanGestureRecognizer.init(target: self, action:#selector(self.collectionTapped(_:)))
            for swipeGesture in swipeGetures {
                panGesture.require(toFail: swipeGesture)
            }
            card.addGestureRecognizer(panGesture)
            card.setAnchors(top: nil, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 22-(CGFloat(CGFloat((count-i))*cardSideWith)), paddingBottom: 0, paddingRight: 22-(CGFloat(CGFloat((count-i))*cardSideWith)), height: 500, width: 0)
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat((i))*cardOversize).isActive = true
            i -= 1
        }
    }
    
    //MARK: Reload button function
    @objc func reload(){
       
        //REMOVE ALL CUSTOM VIEWS TO CREATE NEW VIEWS
        for values in view.subviews
        {
            if values.accessibilityIdentifier == "CustomView"
            {
                values.removeFromSuperview()
            }
        }
        makeView()
    }
    
    func update(){
        currentIndex += 1
    }
    
    func bringPrevious(){
        print("current index:",currentIndex)
        guard let lis = list else {return}
        let count = lis.count
        currentIndex = currentIndex-1
        if currentIndex-1 >= 0
        {
            let card = getView(viewModel: lis[currentIndex-1], totalCardCount: "\(count)")
            card.tag = currentIndex
            //card.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(collectionTapped(_:))))
            let swipeGetures = setupSwipeGestures(view: card)
            let panGesture = UIPanGestureRecognizer.init(target: self, action:#selector(self.collectionTapped(_:)))
            for swipeGesture in swipeGetures {
                panGesture.require(toFail: swipeGesture)
            }
            card.addGestureRecognizer(panGesture)
            self.view.addSubview(card)
            card.setAnchors(top: nil, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 22-(CGFloat(CGFloat((count-currentIndex))*cardSideWith)), paddingBottom: 0, paddingRight: 22-(CGFloat(CGFloat((count-currentIndex))*cardSideWith)), height: 500, width: 0)
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat((currentIndex))*cardOversize).isActive = true
        }
    }
    
    private func setupSwipeGestures(view: UIView) -> [UISwipeGestureRecognizer] {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes))
        
        swipeUp.direction = .up
        swipeDown.direction = .down

        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)

        return [swipeUp, swipeDown]
    }
    
    //MARK: Get Custom View
    func getView(viewModel: ListData,totalCardCount: String)-> UIView{
        
        let card = CustomCardView()
        card.accessibilityIdentifier = "CustomView"
        card.Text.text = viewModel.text
        card.Tracklabel.text = (viewModel.id ?? "")+"/"+totalCardCount
        return card
    }
    
}

//MARK: Handle all animation part
extension ListViewController{
    
    @objc func handleSwipes(gesture: UISwipeGestureRecognizer)
    {
            print("ava")
            bringPrevious()
    }
    
    @objc func collectionTapped(_ sender: UIPanGestureRecognizer)
    {
        print("bca")
        guard let card = sender.view else {return}
        guard let count = list?.count else {return}
        let point = sender.translation(in: view)
        
        //Get center to Handle animation
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x+point.x, y: view.center.y+point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        // handle when gesture ended
        if sender.state == UIGestureRecognizer.State.ended{
            
            if card.center.x+100 < view.frame.width/2{
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: card.center.x - self.view.frame.width, y: card.center.y+75)
            }
                card.removeFromSuperview()
                update()
            return
        }else if card.center.x-100 > view.frame.width/2{
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: card.center.x + self.view.frame.width, y: card.center.y+75)
                }
                card.removeFromSuperview()
                update()
                return
            }
            else{
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
