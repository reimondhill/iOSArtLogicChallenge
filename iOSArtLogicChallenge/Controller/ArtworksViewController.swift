//
//  ArtworksViewController.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class ArtworksViewController: BaseViewController {

    //MARK:- Properties
    private var apiManager: ApiManaging
    private var collectionItems: [CollectionItem] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.artworksTableView.reloadData()
            }
        }
    }
    
    
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
        
        title = "private_views".localized
        setupView()
        loaderOverlay.showOverlay()
        apiManager.getCollections { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.loaderOverlay.hideOverlayView()
                
                switch result {
                case .success(let collectionItems):
                    strongSelf.collectionItems = collectionItems
                    
                    strongSelf.apiManager.startCollectionsRefresh()
                    strongSelf.apiManager.collectionsDidRefresh = { (resultRefresh) in
                        switch resultRefresh {
                        case .success(let collectionItemsRefresh):
                            strongSelf.collectionItems = collectionItemsRefresh
                        case .failure(let errorRefresh):
                            //TODO What will we do?
                            print(strongSelf.logClassName, "ERROR while refreshing: ", errorRefresh)
                        }
                    }
                    
                case .failure(let error):
                    print(strongSelf.logClassName, "ERROR -> ", error)
                    strongSelf.showAlert(withTitle: "error".localized, message: "error_generic".localized, sender: strongSelf, completion: nil)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(PresentationViewController(presentationID: collectionItems[indexPath.row].uid, apiManager: apiManager), animated: true)
        
    }
}
