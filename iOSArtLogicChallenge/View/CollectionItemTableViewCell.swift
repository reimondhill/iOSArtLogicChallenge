//
//  CollectionItemTableViewCell.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit


class CollectionItemTableViewCell: UITableViewCell {

    //MARK:- View Model
    class DataModel {
        private let collectionItem: CollectionItem
        
        var title: String? {
            return collectionItem.caption
        }
        var detailImageURL:URL? {
            return URL(string: collectionItem.images?.mobile ?? "")
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
        
        rtView.clipsToBounds = true
        rtView.contentMode = .scaleAspectFill
        
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
        contentView.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { (maker) in
            maker.top.left.bottom.equalToSuperview()
            maker.width.equalTo(detailImageView.snp.height)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(detailImageView.snp.right)
            maker.top.bottom.right.equalToSuperview()
        }
        
    }
    
    private func update(dataModel: DataModel?) {
        detailImageView.sd_setImage(with: dataModel?.detailImageURL, placeholderImage: nil)
        titleLabel.text = dataModel?.title
    }
    
}
