//
//  ArtworksViewController.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class ArtworksViewController: UIViewController {

    //MARK:- Properties
    private let apiManager: ApiManaging
    private var collectionItems: [CollectionItem] = []
    
    
    //UI
    private lazy var artworksTableView: UITableView = {
        let rtView = UITableView()
        
        rtView.register(CollectionItemTableViewCell.self, forCellReuseIdentifier: CollectionItemTableViewCell.identifier)
        rtView.dataSource = self
        rtView.delegate = self
        rtView.tableFooterView = UIView()
        
        return rtView
    }()
    
    
    //MARK:- Constructor
    init(apiManager: ApiManaging) {
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Lifecycle methods
extension ArtworksViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        apiManager.getHeadlines { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let collectionItems):
                    strongSelf.collectionItems = collectionItems
                    strongSelf.artworksTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }

        }
        
    }
    
}


//MARK:- Private methods
private extension ArtworksViewController {
    
    func setupView() {
        view.addSubview(artworksTableView)
        artworksTableView.constraintToSuperViewEdges()
    }
    
}


//MARK:- UITableView implementation
//MARK: UITableViewDataSource
extension ArtworksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let collectionItemCell:CollectionItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: CollectionItemTableViewCell.identifier, for: indexPath) as? CollectionItemTableViewCell {
        
            collectionItemCell.dataModel = CollectionItemTableViewCell.DataModel(collectionItem: collectionItems[indexPath.row])
            
            return collectionItemCell
        }
        
        
        return UITableViewCell()
    }
    
    
}


//MARK: UITableViewDelegate
extension ArtworksViewController: UITableViewDelegate {
    
}
