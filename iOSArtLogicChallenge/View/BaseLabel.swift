//
//  BaseLabel.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {

    //MARK:- Properties
    //MARK: Constants
    enum LabelConfiguration:Int, CaseIterable{
        //Custom NavBars
        case navBar
        case header
        case subheader
        case title
        case normal
        case normalSmall
        //More future cases
    }
    
    
    //MARK: Vars
    var labelConfiguration:LabelConfiguration {
        didSet{
            setupView()
        }
    }
    
    
    //MARK:- Constructor
    init(withConfiguration labelConfiguration:LabelConfiguration) {
        
        self.labelConfiguration = labelConfiguration
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Private methods
private extension BaseLabel{
    
    func setupView(){
        
        numberOfLines = 0
        textAlignment = .left
        
        switch labelConfiguration {
        case .navBar:
            textColor = UIColor.navigationBarText
            font = UIFont (name: "Helvetica-Bold", size: TextSize.navigationTitle)
        case .header:
            textColor = UIColor.mainText
            font = UIFont (name: "Helvetica-Bold", size: TextSize.header)
        case .subheader:
            textColor = UIColor.mainText
            font = UIFont (name: "Helvetica-Bold", size: TextSize.subHeader)
        case .title:
            textColor = UIColor.mainText
            font = UIFont (name: "Helvetica-Bold", size: TextSize.title)
        case .normal:
            textColor = UIColor.mainText
            font = UIFont (name: "Helvetica", size: TextSize.normal)
            textAlignment = .justified
        case .normalSmall:
            textColor = UIColor.mainText
            font = UIFont.systemFont(ofSize: TextSize.normalSmall, weight: .light)
        }
        
    }
    
}
