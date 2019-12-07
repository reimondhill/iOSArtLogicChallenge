//
//  PresentationViewController.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {

    //MARK: - Properties
    private let presentationID: String
    private let apiManager: ApiManaging
    private var presentationResponse: PresentationResponse? {
        didSet {
            updateView(presentationResponse: presentationResponse)
        }
    }
    
    //UI
    lazy var scrollView: UIScrollView = {
        let rtView = UIScrollView()
        
        return rtView
    }()
    lazy var topView: UIImageView = {
        let rtView = UIImageView()
        
        rtView.contentMode = .scaleAspectFill
        rtView.clipsToBounds = true
        
        return rtView
    }()
    lazy var presentationStackView: UIStackView = {
        let rtView = UIStackView()
        
        rtView.alignment = .center
        rtView.distribution = .fillProportionally
        rtView.axis = .vertical
        rtView.spacing = Margins.medium
        
        return rtView
    }()
    
    
    //MARK: - Constructor
    init(presentationID: String, apiManager: ApiManaging) {
        self.presentationID = presentationID
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Lifecycle methods
extension PresentationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        apiManager.getPresentation(uid: presentationID) { [weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let presentationResponse):
                    strongSelf.presentationResponse = presentationResponse
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
        
    }
    
}


//MARK: - Private methods
private extension PresentationViewController {
    
    func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (builder) in
            builder.top.left.bottom.right.equalToSuperview()
        }
        
        scrollView.addSubview(topView)
        topView.snp.makeConstraints { (builder) in
            builder.top.left.right.equalToSuperview()
            builder.width.equalToSuperview()
            builder.height.equalTo(view.frame.height / 2)
        }
        
        scrollView.addSubview(presentationStackView)
        presentationStackView.snp.makeConstraints { (builder) in
            builder.top.equalTo(topView.snp.bottom)
            
            builder.left.bottom.right.equalToSuperview()
        }
        
    }
    
    func updateView(presentationResponse: PresentationResponse?) {
        guard let presentationResponse = presentationResponse else { return }
        
        topView.sd_setImage(with: URL(string: presentationResponse.presentationItems[0].imageSet.fullSize ?? ""), placeholderImage: nil)
        
        for item in presentationResponse.presentationItems {
            let aView = UIView()
            let aLabel = BaseLabel(withConfiguration: .headline)
            aLabel.text = "Puta"
            aView.backgroundColor = .green
            presentationStackView.addArrangedSubview(aLabel)
        }
        
    }
    
}
