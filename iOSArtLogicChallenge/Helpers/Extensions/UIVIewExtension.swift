//
//  UIVIewExtension.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//


import UIKit


extension UIView{
    
    //MARK:- Properties
    /// Returns the UIViewController for the UIVIew
    var viewControler:UIViewController?{
        return findViewController()
    }
    
    
    //MARK:- Methods
    /// Tries to find if there is a UIVievontroller containing the view
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        }
        else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        }
        else {
            return nil
        }
    }
    
    ///Adds a border to the UIView and returns the UIView if needed
    /// - Parameters:
    ///   - borderWidth: Size of the border
    ///   - radius: Corner radius for each border
    ///   - color: Color for the border
    func addBorder(borderWidth:CGFloat, radius:CGFloat, color:UIColor){
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    ///Adds a Top separator and returns the UIView if needed
    /// - Parameters:
    ///   - color: Color for the separator view
    ///   - height: Size of the separator view
    ///   - margins: Horizontal margins
    @discardableResult
    func addTopSeparator(color: UIColor, height: CGFloat, margins:CGFloat)->UIView {
        
        let border = UIView()
        
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: height))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: margins))
        
        return border
        
    }
    
    ///Adds a Right separator and returns the UIView if needed
    /// - Parameters:
    ///   - color: Color for the separator view
    ///   - width: Size of the separator view
    ///   - margins: Vertical margins
    @discardableResult
    func addRightSeparator(color: UIColor, width: CGFloat, margins:CGFloat) -> UIView{
        
        let border = UIView()
        
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: -margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: 0))
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: width))
        
        return border
        
    }
    
    ///Adds a Bottom separator and returns the UIView if needed
    /// - Parameters:
    ///   - color: Color for the separator view
    ///   - height: Size of the separator view
    ///   - margins: Horizontal margins
    @discardableResult
    func addBottomSeparator(color: UIColor, height: CGFloat, margins:CGFloat) -> UIView{
        
        let border = UIView()
        
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: height))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1, constant: margins))
        
        return border
        
    }
    
    ///Adds a Left separator and returns the UIView if needed
    /// - Parameters:
    ///   - color: Color for the separator view
    ///   - width: Size of the separator view
    ///   - margins: Vertical margins
    @discardableResult
    func addLeftSeparator(color: UIColor, width: CGFloat, margins:CGFloat) -> UIView{
        
        let border = UIView()
        
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1, constant: -margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1, constant: 0))
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutConstraint.Attribute.width,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutConstraint.Attribute.height,
                                                multiplier: 1, constant: width))
        
        return border
        
    }
    
    
    struct AnchoredConstraints {
            var top, leading, bottom, trailing, width, height, centerX, centerY: NSLayoutConstraint?
        }
        
        ///Constrait to superView with optional margins
        @discardableResult
        func constraintToSuperViewEdges(padding:UIEdgeInsets = .zero) -> AnchoredConstraints?{
            
            guard let superview = superview else{ return nil }
            
            var anchoredConstraints = AnchoredConstraints()
            translatesAutoresizingMaskIntoConstraints = false
            
            anchoredConstraints.top = topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top)
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right)
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: padding.bottom)
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left)
            
            [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing].forEach{ $0?.isActive = true }
            
            return anchoredConstraints
        }
        
        @discardableResult
        ///Freestyle constraints setup. Width/Height or Size
        func anchor(top: NSLayoutYAxisAnchor?,
                    leading: NSLayoutXAxisAnchor?,
                    bottom: NSLayoutYAxisAnchor?,
                    trailing: NSLayoutXAxisAnchor?,
                    padding: UIEdgeInsets = .zero,
                    width: NSLayoutDimension? = nil,
                    height: NSLayoutDimension? = nil,
                    widthMultiplier: CGFloat = 1,
                    heightMultiplier: CGFloat = 1,
                    centerX: NSLayoutXAxisAnchor? = nil,
                    centerY: NSLayoutYAxisAnchor? = nil,
                    size: CGSize? = nil,
                    safeAreaLayoutGuide:Bool = false) -> AnchoredConstraints {
            
            translatesAutoresizingMaskIntoConstraints = false
            var anchoredConstraints = AnchoredConstraints()
            
            if let top = top {
                anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
            }
            
            if let leading = leading {
                anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            }
            
            if let bottom = bottom {
                anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            }
            
            if let trailing = trailing {
                anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            }
            
            if let width = width{
                anchoredConstraints.width = widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier)
            }
            
            if let height = height{
                anchoredConstraints.height = height.constraint(equalTo: height, multiplier: heightMultiplier)
            }
            
            if let centerX = centerX{
                anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: centerX)
            }
            
            if let centerY = centerY{
                anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: centerY)
            }
            
            if let size = size{
                if size.width > 0{
                    anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
                }
                if size.height > 0{
                    anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
                }
            }
            
            
            [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height, anchoredConstraints.centerY, anchoredConstraints.centerX].forEach{ $0?.isActive = true }
            
            return anchoredConstraints
        }
        
        @discardableResult
        func centerInSuperview(size: CGSize = .zero) -> AnchoredConstraints{
            
            var anchoredConstraints = AnchoredConstraints()
            translatesAutoresizingMaskIntoConstraints = false
            
            if let superviewCenterXAnchor = superview?.centerXAnchor {
                anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: superviewCenterXAnchor)
            }
            
            if let superviewCenterYAnchor = superview?.centerYAnchor {
                anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: superviewCenterYAnchor)
            }
            
            if size.width != 0 {
                anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
            }
            
            if size.height != 0 {
                anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
            }
            
            [anchoredConstraints.centerX, anchoredConstraints.centerY, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
            
            return anchoredConstraints
        }
        
        
    }
