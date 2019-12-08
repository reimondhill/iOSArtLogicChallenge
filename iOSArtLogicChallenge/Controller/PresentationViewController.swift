//
//  PresentationViewController.swift
//  iOSArtLogicChallenge
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import UIKit

class PresentationViewController: BaseViewController {

    //MARK: - Properties
    private let presentationID: String
    private let apiManager: ApiManaging
    private let queue = DispatchQueue(label: "PresentationQueue", qos: .userInteractive)
    private var presentationResponse: PresentationResponse? {
        didSet {
            updateView(presentationResponse: presentationResponse)
        }
    }
    
    //UI
    private lazy var scrollView: UIScrollView = {
        let rtView = UIScrollView()
        
        rtView.bounces = false
        rtView.delegate = self
        
        return rtView
    }()
    private lazy var contenView: UIView = { return UIView()}()
    
    //TODO Replace to its own UIView
    private lazy var headerImageView: UIImageView = {
        let rtView = UIImageView()
        
        rtView.contentMode = .scaleAspectFill
        rtView.clipsToBounds = true
        
        return rtView
    }()
    private lazy var headerTitleLabel: BaseLabel = {
        let rtView = BaseLabel(withConfiguration: .header)
        
        rtView.textAlignment = .center
        rtView.textColor = UIColor.mainTextInverted
        
        return rtView
    }()
    
    private lazy var presentationContainerView: UIView = { return UIView() }()
    
    
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
        
        makeTransparentNavigationBar()
        setupView()
        loaderOverlay.showOverlay()
        apiManager.getPresentation(uid: presentationID) { [weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.loaderOverlay.hideOverlayView()
                
                switch result {
                case .success(let presentationResponse):
                    strongSelf.presentationResponse = presentationResponse
                case .failure(let error):
                    print(strongSelf.logClassName, "ERROR -> ", error)
                    strongSelf.showAlert(withTitle: "error".localized, message: "error_generic".localized, sender: strongSelf, completion: nil)
                }
                
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        makeSolidtNavigationBar()
    }
    
}


//MARK: - Private methods
private extension PresentationViewController {
    
    func setupView() {
        isScrolling = true
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (builder) in
            builder.top.equalToSuperview().inset(-2*topbarHeight)
            builder.left.bottom.right.equalToSuperview()
        }
        
        scrollView.addSubview(contenView)
        contenView.snp.makeConstraints { (builder) in
            builder.top.left.bottom.right.equalToSuperview()
            builder.width.equalToSuperview()
        }
        
        contenView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (builder) in
            builder.top.equalToSuperview()
            builder.left.right.equalToSuperview()
            builder.height.equalTo((view.frame.height * 2) / 3)
        }
        headerImageView.addSubview(headerTitleLabel)
        headerTitleLabel.snp.makeConstraints { (builder) in
            builder.left.right.equalToSuperview()
            builder.centerX.equalToSuperview()
            builder.centerY.equalToSuperview()
        }
        
        contenView.addSubview(presentationContainerView)
        presentationContainerView.snp.makeConstraints { (builder) in
            builder.top.equalTo(headerImageView.snp.bottom).inset(-Margins.large)
            builder.left.right.equalToSuperview()
            builder.height.equalTo(0).priority(.low)
            builder.bottom.equalToSuperview()
            builder.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    func updateView(presentationResponse: PresentationResponse?) {
        guard let presentationResponse = presentationResponse else { return }
        
        let firstPresentation = presentationResponse.presentationItems[0]
        titleView.title = presentationResponse.galleryName

        headerImageView.sd_setImage(with: URL(string: firstPresentation.imageSet.fullSize ?? ""), placeholderImage: nil)
        headerTitleLabel.text = presentationResponse.galleryName

        let dispatchGroup = DispatchGroup()
        let presentationStackView = UIStackView()
        presentationStackView.alignment = .fill
        presentationStackView.distribution = .fill
        presentationStackView.axis = .vertical
        presentationStackView.spacing = Margins.medium
        
        presentationContainerView.addSubview(presentationStackView)
        presentationStackView.snp.makeConstraints { (builder) in
            builder.top.left.bottom.right.equalToSuperview().inset(Margins.medium)
        }
    
        for item in presentationResponse.presentationItems.dropFirst() {
            dispatchGroup.enter()
            
            queue.async { [weak self] in
                guard let strongSelf = self else { return }
                
                if let imageURL = URL(string: item.imageSet.defaultImage ?? ""),
                    let imageData = try? Data(contentsOf: imageURL),
                    let image = UIImage(data: imageData){
                    
                    DispatchQueue.main.async {
                        
                        let presetationItemView = UIStackView()
                        presetationItemView.alignment = .top
                        presetationItemView.distribution = .fillProportionally
                        presetationItemView.axis = .horizontal
                        presetationItemView.spacing = Margins.xSmall
                        
                        // Add image
                        let imageView = UIImageView(image: image)
                        let width:CGFloat = strongSelf.view.frame.size.width / 3
                        let height = width * (1 / image.aspectRatioValue)
                        imageView.snp.makeConstraints { (builder) in
                            builder.width.equalTo(width)
                            builder.height.equalTo(height)
                        }
                        presetationItemView.addArrangedSubview(imageView)
                        
                        // Add caption
                        let sectionCaptionLabel = BaseLabel(withConfiguration: .normal)
                        let captionSeparated = item.rowCaption.components(separatedBy: ",")
                        let combination = NSMutableAttributedString()
                        for i in 0 ..< captionSeparated.count {
                            let font = i == 0 ? UIFont.bold(size: TextSize.normal):UIFont.regular(size: TextSize.normal)
                            let attributes = [NSAttributedString.Key.font: font]
                            let attString = NSAttributedString(string: " \(i == 0 ? " ":"") \(captionSeparated[i])\n", attributes: attributes)
                            combination.append(attString)
                        }
                        sectionCaptionLabel.attributedText = combination
                        presetationItemView.addArrangedSubview(sectionCaptionLabel)
                        
                        
                        presentationStackView.addArrangedSubview(presetationItemView)
                        dispatchGroup.leave()
                        
                    }
                    
                }
                else {
                    dispatchGroup.leave()
                }
                
            }
            
        }
        
    }
    
}


//MARK:- UIScrollViewDelegate implementation
extension PresentationViewController: UIScrollViewDelegate {
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let labelAbsolutePoint = headerTitleLabel.convert(headerTitleLabel.bounds.origin, to: view)
        
        let invertedAbsolutePointY = -labelAbsolutePoint.y
        titleView.updateTitleMargin(invertedAbsolutePointY)
        
        if invertedAbsolutePointY > -88 {
            makeSolidtNavigationBar()
        }
        else {
            makeTransparentNavigationBar()
        }
        //print(logClassName, "TEST -> ", invertedAbsolutePointY)
    }
    
}
