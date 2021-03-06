//
//  SelfieShareVC.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit
import MultipeerConnectivity

class SelfieShareVC: UIViewController {
	
	// MARK: Properties
	
	// For UI
	private var collectionView			: UICollectionView!
	private var images					= [UIImage]()
	
	// For broadcasting
	var peerID							: MCPeerID!
	var mcSession						: MCSession?
	var mcAdAssistant					: MCNearbyServiceAdvertiser!
	
	// MARK: Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureCollectionView()
		configureMultipeerConnection()
	}
}


// MARK: Data Source

extension SelfieShareVC: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelfieCell.reuseID, for: indexPath)
		if let imageView = cell.viewWithTag(1000) as? UIImageView { imageView.image = images[indexPath.item] }
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
}


// MARK: Add & Send Pictures
extension SelfieShareVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	final func importPicture(via action: UIAction, using type: UIImagePickerController.SourceType) {
		let picker				= UIImagePickerController()
		picker.sourceType		= type
		picker.allowsEditing	= true
		picker.delegate			= self
		present(picker, animated: true)
	}
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }
		dismiss(animated: true)
		
		updateSourceData(with: image)
		broadcast(with: image)
	}

	
	// MARK: Broadcasting-end Method
	func broadcast(with image: UIImage) {
		guard let mcSession = mcSession else { return }
		if mcSession.connectedPeers.isEmpty == false {
			if let imageData = image.pngData() {
				do { try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable) }
				catch { presentAlertOnMainThread(title: "Send Error", message: error.localizedDescription, buttonTitle: "Ok") }
			}
		}
	}
	
	// challenge 2
	func broadcast(with text: String) {
		guard let mcSession = mcSession else { return }
		if mcSession.connectedPeers.isEmpty == false {
			let textData = Data(text.utf8)
			do { try mcSession.send(textData, toPeers: mcSession.connectedPeers, with: .reliable) }
			catch { presentAlertOnMainThread(title: "Send Error", message: error.localizedDescription, buttonTitle: "Ok") }
		}
	}
	
	
	// MARK: Display Broadcasting Result
	func updateSourceData(with image: UIImage) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.images.insert(image, at: 0)
			self.collectionView.reloadData()
		}
	}
}


// MARK: Broadcasting
extension SelfieShareVC: MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {
	
	final func configureMultipeerConnection() {
		peerID					= MCPeerID(displayName: UIDevice.current.name)
		mcSession				= MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
		mcSession?.delegate		= self
	}
	
	
	final func startHosting(via action: UIAction) {
		guard mcSession			!= nil else { return }
		mcAdAssistant			= MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: MCConnectivity.serviceID)
		mcAdAssistant?.delegate	= self
		mcAdAssistant?.startAdvertisingPeer()
	}
	
	
	final func stopSession(via action: UIAction) {
		mcAdAssistant?.stopAdvertisingPeer()
		mcSession?.disconnect() // challenge 1
	}
	
	
	final func joinSession(via action: UIAction) {
		guard let mcSession 	= mcSession else { return }
		let mcBrowser			= MCBrowserViewController(serviceType: MCConnectivity.serviceID, session: mcSession)
		mcBrowser.delegate		= self
		mcBrowser.modalPresentationStyle = .pageSheet
		present(mcBrowser, animated: true)
	}
	
	
	#warning("IMPORTANT METHOD TO ALLOW CONNECTION ON THE HOST")
	func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
		
		let ac = UIAlertController(title: title, message: "\(peerID.displayName) wants to connect", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Allow", style: .default, handler: { [weak self] _ in
			invitationHandler(true, self?.mcSession)
		}))
		ac.addAction(UIAlertAction(title: "Decline", style: .cancel, handler: { _ in
			invitationHandler(false, nil)
		}))
		present(ac, animated: true)
	}
}


// MARK: Browser Delegate Methods
extension SelfieShareVC: MCBrowserViewControllerDelegate {
	func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
	
	func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }
	
	func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {	}
	
	func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
		dismiss(animated: true)
	}
	
	func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
		dismiss(animated: true)
	}
	
	// MARK: Receiving-end Method
	// challenge 2
	final func didReceiveMessage(using data: Data, from peerID: MCPeerID) {
		let message = String(decoding: data, as: UTF8.self)
		let replyAction = UIAlertAction(title: "Reply to \(peerID.displayName)", style: .default) { [weak self] action in
			self?.presentMessagePrompt(via: action)
		}
		presentAlertOnMainThread(title: "Message from \(peerID.displayName)", message: message, buttonTitle: "Ok", otherActions: [replyAction])
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		// receiving end of the broadcast session
		if let image = UIImage(data: data) {
			updateSourceData(with: image)
			return
		}
		
		didReceiveMessage(using: data, from: peerID)
	}

	
	func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		// for debugging
		switch state {
		case .connected:
			print("Connected: \(peerID.displayName)")
			updateNavBarForConnected() // challenge 3
			
		case .connecting:
			print("Connecting: \(peerID.displayName)")
			updateNavBarForConnected() // challenge 3
			
		case .notConnected:
			print("Not Connected: \(peerID.displayName)")
			presentAlertOnMainThread(title: "Disconnected", message: "\(peerID.displayName) has disconnected from the share session", buttonTitle: "Ok") // challenge 1
			updateNavBarForConnected() // challenge 3
			
		@unknown default:
			print("Unknown State Received: \(peerID.displayName)")
			updateNavBarForConnected() // challenge 3
		}
	}
}


extension SelfieShareVC {
	// challenge 2
	
	// to be reuse by "Text Message" option from the Add menu
	func presentMessagePrompt(via action: UIAction) {
		let ac = UIAlertController(title: "New Message", message: "Make sure you connected to another device using \(Bundle.main.displayName ?? "the same app"), too", preferredStyle: .alert)
		ac.addTextField()
		
		let sendAction = UIAlertAction(title: "Send", style: .default, handler: { [weak self, weak ac] action in
			guard let message = ac?.textFields?[0].text else { return }
			self?.broadcast(with: message)
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		
		ac.addActions(sendAction, cancelAction)
		present(ac, animated: true)
	}
	
	// to be reuse by the "Reply" option upon receiving a message
	func presentMessagePrompt(via action: UIAlertAction) {
		let ac = UIAlertController(title: "New Message", message: "Make sure you connected to another device using \(Bundle.main.displayName ?? "the same app"), too", preferredStyle: .alert)
		ac.addTextField()
		
		let sendAction = UIAlertAction(title: "Send", style: .default, handler: { [weak self, weak ac] action in
			guard let message = ac?.textFields?[0].text else { return }
			self?.broadcast(with: message)
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		
		ac.addActions(sendAction, cancelAction)
		present(ac, animated: true)
	}
}


// MARK: UI Config

extension SelfieShareVC: UICollectionViewDelegate {
	
	final func configureViewController() {
		view.backgroundColor	= .systemBackground
		title					= Bundle.main.displayName
		
		let spacer				= UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		setToolbarItems([configureConnectButton(), spacer, configureAddButton()], animated: true)
		navigationController?.isToolbarHidden = false
	}
	
	
	final func configureConnectButton() -> UIBarButtonItem {
		
		let host	= UIAction(title: "Host Session", image: Image.host) { [weak self] (action) in
			self?.startHosting(via: action)
		}
		
		let join	= UIAction(title: "Join Session", image: Image.join) { [weak self] (action) in self?.joinSession(via: action)
		}
		
		let stop	= UIAction(title: "Stop Session", image: Image.stop, attributes: .destructive) { [weak self] action in self?.stopSession(via: action)
		}
		
		let menu	= UIMenu(title: "Multipeer Connectivity", image: nil, identifier: nil, options: [], children: [host, join, stop])
		return UIBarButtonItem(title: nil, image: Image.connection, primaryAction: nil, menu: menu)
	}
	
	
	final func configureAddButton() -> UIBarButtonItem {
		
		let camera	= UIAction(title: "Photos from Camera", image: Image.camera, handler: { [weak self] (action) in self?.importPicture(via: action, using: .camera)
		})

		let library	= UIAction(title: "Photos from Library", image: Image.photoLibrary, handler: { [weak self] (action) in self?.importPicture(via: action, using: .photoLibrary)
		})
		
		let text	= UIAction(title: "Text Message", image: Image.messageBubble) { [weak self] (action) in self?.presentMessagePrompt(via: action)
		}
		
		var actions	= [UIAction]()
		#if targetEnvironment(simulator)
		actions		= [library, text]
		#else
		actions		= [camera, library, text]
		#endif
		let menu = UIMenu(title: "Data To Send", image: nil, identifier: nil, options: [], children: actions)
		return UIBarButtonItem(title: nil, image: Image.add, primaryAction: nil, menu: menu)
	}
	
	
	// challenge 3
	#warning("Don't add a guard check on MCSessionState otherwise there's a bug that removes the button regardless of how many devices still connected to the session")
	private func updateNavBarForConnected() {
		guard
			let mcSession = mcSession,
			mcSession.connectedPeers.isEmpty == false
		else {
			updateNavBarLeftItem(with: nil)
			return
		}
		
		var connectedDeviceList: [UIAction] = []
		mcSession.connectedPeers.forEach { device in
			let action = UIAction(title: device.displayName, image: Image.iPhone) { (_) in }
			connectedDeviceList.append(action)
			
		let connectedMenu = UIMenu(title: "Connected Devices", image: nil, identifier: nil, options: [], children: connectedDeviceList)
			
		let connectedDeviceItem = UIBarButtonItem(title: "Connected Devices", image: Image.connected, primaryAction: nil, menu: connectedMenu)
		updateNavBarLeftItem(with: connectedDeviceItem)
		}
	}
	
	
	final func configureCollectionView() {
		let flowLayout					= UICollectionViewFlowLayout()
		flowLayout.configureTwoColumnFlowLayout(in: view)
		
		collectionView					= UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
		collectionView.backgroundColor 	= .systemBackground
		collectionView.dataSource		= self
		collectionView.delegate			= self
		collectionView.register(SelfieCell.self, forCellWithReuseIdentifier: SelfieCell.reuseID)
		view.addSubview(collectionView)
	}
}
