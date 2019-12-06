//
//  CollectionItemTableViewCell.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit
import SDWebImage


class CollectionItemTableViewCell: UITableViewCell {

    //MARK:- View Model
    class DataModel {
        private let collectionItem: CollectionItem
        
        var title: String? {
            return collectionItem.caption
        }
        
        init(collectionItem: CollectionItem) {
            self.collectionItem = collectionItem
        }
        
    }
    
    
    //MARK: - Properties
    var dataModel: DataModel? {
        didSet {
            update(dataModel: dataModel)
        }
    }
    
    //UI
    private lazy var titleLabel: BaseLabel = {
        return BaseLabel(withConfiguration: .normal)
    }()
    private lazy var detailImageView: UIImageView = {
        let rtView = UIImageView()
        
        rtView.contentMode = .scaleAspectFit
        
        return rtView
    }()
    
}


//MARK: - Lifecycle methods
extension CollectionItemTableViewCell {
    
    override func didMoveToSuperview() {
        if superview != nil {
            setupView()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        detailImageView.image = nil
        
    }

}


//MARK: - Private methods
private extension CollectionItemTableViewCell {
    
    private func setupView(){
        contentView.addSubview(titleLabel)
        titleLabel.constraintToSuperViewEdges()
    }
    
    private func update(dataModel: DataModel?) {
        titleLabel.text = dataModel?.title
    }
    
}
