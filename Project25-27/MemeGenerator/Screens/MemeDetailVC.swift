//
//  MemeDetailVC.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit

class MemeDetailVC: UIViewController {
	
	// MARK: Properties
	
	private var image			: UIImage!
	private var imageView		: MGImageView!
	weak var delegate			: MemeListVCDelegate!

	init(image: UIImage, delegate: MemeListVCDelegate) {
		super.init(nibName: nil, bundle: nil)
		self.image = image
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureViewController()
		configureImageView()
	}
}


// MARK: UI Config

extension MemeDetailVC {
	
	final func configureViewController() {
		view.backgroundColor	= .systemBackground
		
		let closeButton			= UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItems	= [closeButton, makeShareButton()]
		navigationItem.leftBarButtonItems	= [makeCaptionButton()]
	}
	
	
	final func configureImageView() {
		imageView = MGImageView(frame: .zero)
		view.addSubview(imageView)
		imageView.pinToEdges(of: view)
		
		imageView.image = image
	}
	
	
	@objc
	private func dismissVC() { dismiss(animated: true) }
	
	
	private func makeCaptionButton() -> UIBarButtonItem {
		let topCaption		= UIAction(title: "Top Caption", image: SFSymbol.topCaption) { [weak self] action in
			self?.addCaption(via: action, at: .top)
		}
		let bottomCaption	= UIAction(title: "Bottom Caption", image: SFSymbol.topCaption) { [weak self] action in
			self?.addCaption(via: action, at: .bottom)
		}
		let captionMenu		= UIMenu(title: "Add Captions", image: nil, identifier: nil, options: [], children: [topCaption, bottomCaption])
		return UIBarButtonItem(title: nil, image: SFSymbol.caption, primaryAction: nil, menu: captionMenu)
	}
	
	
	private func makeShareButton() -> UIBarButtonItem {
		return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShareButton))
	}
}


// MARK: Logic
extension MemeDetailVC {
		
	final func addCaption(via action: UIAction, _ caption: String? = nil, at position: CaptionPosition) {
		
		presentCaptionPrompt(via: action, for: position) { [weak self] caption in
			if let self = self, let image = self.imageView.image, let caption = caption {
				let moddedImage			= self.imageView.imageWithCaption(from: image, with: caption, captionPosition: position)
				self.imageView.image	= moddedImage
				self.delegate.didReceiveImage(moddedImage!)
			}
		}
	}
	
	
	@objc
	final func didTapShareButton() {
		guard let image = imageView.image else { return }
		let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
		present(vc, animated: true)
	}
}
