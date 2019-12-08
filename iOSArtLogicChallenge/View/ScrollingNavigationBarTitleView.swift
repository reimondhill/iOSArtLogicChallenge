//
//  ScrollingNavigationBarTitleView.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 07/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class ScrollingNavigationBarTitleView: UIView {

      //MARK:- Properties
      private (set) var titleLabelMargin:CGFloat = 0
      var isScrolling = false
      
      var title:String?{
          didSet{
              titleLabel.text = title
          }
      }
      lazy private var titleLabel: BaseLabel = {
          let rtView = BaseLabel(withConfiguration: .navBar)
          
          rtView.textAlignment = .center
          rtView.text = title
          rtView.isHidden = isScrolling
          
          return rtView
      }()
      
      
      //MARK:- Constructor
      required init(isScrolling:Bool) {
          self.isScrolling = isScrolling
          super.init(frame: CGRect())
        
          clipsToBounds = true
        
    }
      
      override init(frame: CGRect) {
          super.init(frame: CGRect())
          clipsToBounds = true

      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("Sorry i don't see the point right now ... maybe later")
      }
      
      
      //MARK:- Lifecycle methods
      override func didMoveToSuperview() {
          super.didMoveToSuperview()
          
          if superview != nil{
              //It has been added
              initialize()
          }
          
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
          //print("\(logClassName) Did layout subviews Frame: \(frame)")
          updateFrames()
          
      }
      
      
      
      //MARK:- Private methods
      private func initialize(){
          
          addSubview(titleLabel)
          updateFrames()
          
      }
      
      private func updateFrames(){
          
          if isScrolling{
          
              titleLabel.frame = CGRect(x: 0,
                                        y: frame.height - titleLabelMargin,
                                        width: frame.width,
                                        height: frame.height)
          
          }
          else{
              
              titleLabel.frame = CGRect(x: 0,
                                        y: 0,
                                        width: frame.width,
                                        height: frame.height)
              
          }
          
      }
      
      
      
      //MARK:- Public methods
      func updateTitleMargin(_ newMargin:CGFloat){
        
        if isScrolling{
            //print(logClassName, "TEST -> ", newMargin)
            titleLabelMargin = newMargin
            if titleLabelMargin > 0{
                
                titleLabel.isHidden = false
    
                if titleLabelMargin <= frame.height{
                    
                    var currentTitleLabelFrame = titleLabel.frame
                    currentTitleLabelFrame.origin.y = frame.height - newMargin
                    titleLabel.frame = currentTitleLabelFrame
                    
                }
                else if titleLabelMargin > frame.height{
                    
                    updateTitleMargin(frame.height)
                    
                }
                
            }
            else{
                
                titleLabel.isHidden = true
                
            }
            
        }
        
    }
}
