//
//  GalleryViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 07.Jun.22.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private var leftConstraint = NSLayoutConstraint()
    private var rightConstraint = NSLayoutConstraint()
    
    @IBOutlet weak private var userMessage: UILabel!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var comment: UITextField!
    @IBOutlet weak private var commentView: UIView!
    @IBOutlet weak private var commentHeight: NSLayoutConstraint!
    @IBOutlet weak private var scrollViewContent: UIView!
    @IBOutlet weak private var scrollViewBottom: NSLayoutConstraint!
    
    private var commentViews: [CommentInfoView] = []
    private var textComment: String?
    private var commentIsHidden = false
    private var photoList: [PhotoInfo] = []
    private var imageList: Dictionary<String, UIImage> = [:]
    private var currentIndex = 0
    private var currentImage = GalleryView() {
        didSet {
            showPhoto()
            currentImage.delegate = self
        }
    }
    private let documentsFolderURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private lazy var imagesFolderURL: URL = documentsFolderURL.appendingPathComponent("images")
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentImage.delegate = self
        setupSwipeDirection()
        setupFileManager()
        comment.delegate = self
        setupObservers()
        setupImage()
        setupCommentView()
        
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.scrollView.contentInset = .zero
        }
    }
    
    @IBAction func textFiledShouldChange(_ sender: UITextField) {
        textComment = sender.text
            }
    
    private func setupImage() {
        if !imageList.isEmpty {
            currentImage.removeFromSuperview()
            let gallery = GalleryView(frame: contentView.bounds)
            currentImage = gallery
            guard let photo = imageList[photoList[currentIndex].getName()] else {
                return
            }
            currentImage.setLikeStatus(status: photoList[currentIndex].getLikeState())
            currentImage.addImage(image: photo)
            currentImage.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(currentImage)
            recalculationConstraints()
            userMessage.isHidden = true
        }
       
    }
    
    
    private func setupFileManager() {
        if UserDefaults.standard.data(forKey: "photoInfo") == nil {
            let array: [PhotoInfo] = []
            let placeArray = try! JSONEncoder().encode(array)
            UserDefaults.standard.set(placeArray, forKey: "photoInfo")
        }
        if FileManager.default.fileExists(atPath: imagesFolderURL.path) == false {
            try? FileManager.default.createDirectory(at: imagesFolderURL, withIntermediateDirectories: false)
        }
        let imageNames = try! FileManager.default.contentsOfDirectory(atPath: imagesFolderURL.path).filter({$0.contains(".png")}).sorted()
        let imageURL = documentsFolderURL.appendingPathComponent("images")
        var images: Dictionary<String, UIImage> = [:]
        let photos: [PhotoInfo] = getPhotoInfo()
        for imageName in imageNames {
            let image = imageURL.appendingPathComponent(imageName)
            let data = try! Data(contentsOf: image)
            let photo = UIImage(data: data)!
            images[imageName] = photo
        }
        photoList = photos
        imageList = images
    }
    
    private func showImagePicker(camera: Bool) {
        let picker = UIImagePickerController()
        if camera {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func savePhotoInfo(photoInfo: PhotoInfo) {
        let data = UserDefaults.standard.data(forKey: "photoInfo")
        var array = try! JSONDecoder().decode([PhotoInfo].self, from: data!)
        array.append(photoInfo)
        let placeData = try! JSONEncoder().encode(array)
        UserDefaults.standard.set(placeData, forKey: "photoInfo")
    }
    
    private func getPhotoInfo() -> [PhotoInfo] {
        let data = UserDefaults.standard.data(forKey: "photoInfo")
        let array = try! JSONDecoder().decode([PhotoInfo].self, from: data!)
        return array
    }
    
    private func updatePhotoInfo(data: [PhotoInfo]) {
        let placeData = try! JSONEncoder().encode(data)
        UserDefaults.standard.set(placeData, forKey: "photoInfo")
    }
    
    private func showImagePickerAlert() {
        
        let alert = AlertView(frame: view.bounds)
        alert.addButton(title: "Gallery", style: .normal, action: UIAction(handler: { _ in
            self.showImagePicker(camera: false)
        }))
        alert.addButton(title: "Cancel", style: .normal, action: UIAction(handler: { _ in
            
        }))
        view.addSubview(alert)
    }
    
    private func recalculationConstraints() {
        
        leftConstraint = NSLayoutConstraint(item: currentImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        leftConstraint.isActive = true
        rightConstraint = NSLayoutConstraint(item: currentImage, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        rightConstraint.isActive = true
        currentImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        currentImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setupSwipeDirection() {
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.addTarget(self, action: #selector(handleSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.addTarget(self, action: #selector(handleSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc
    private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .right:
            if currentIndex == photoList.startIndex {
                currentIndex = photoList.endIndex
            }
            swipeOn(direction: .right, view: currentImage)
            if commentIsHidden {
                commentHeight.constant = 25
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                    self.view.layoutIfNeeded()
                } completion: { _ in
                    self.commentView.isHidden = true
                    self.commentIsHidden.toggle()
            }
            }
            
        case .left :
            if currentIndex == photoList.count - 1 {
                currentIndex = photoList.startIndex - 1
            }
            swipeOn(direction: .left, view: currentImage)
            if commentIsHidden {
                commentHeight.constant = 25
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                    self.view.layoutIfNeeded()
                } completion: { _ in
                    self.commentView.isHidden = true
                    self.commentIsHidden.toggle()
            }
            }
           
        default:
            return
        }
    }
    
    private func swipeOn(direction: SwipeOn, view: GalleryView) {
        
        switch direction {
        case .left:
            if !photoList.isEmpty {
                leftConstraint.isActive = false
                rightConstraint.constant = contentView.frame.minX - currentImage.frame.width
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                    self.contentView.layoutIfNeeded()
                } completion: { _ in
                    self.currentIndex += 1
                    self.setupImage()
                    self.setupCommentView()
                }
            }
            
            

        case .right:
            if !photoList.isEmpty {
                rightConstraint.isActive = false
                leftConstraint.constant = contentView.frame.maxX + currentImage.frame.width
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                    self.contentView.layoutIfNeeded()
                } completion: { _ in
                    self.currentIndex -= 1
                    self.setupImage()
                    self.setupCommentView()
                }
            }
        }
        
    }
    
    private func commentViewAction() {
        if !commentIsHidden {
            commentView.isHidden = false
            commentHeight.constant = 150
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.commentIsHidden.toggle()
            }
        } else {
            commentHeight.constant = 25
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.commentView.isHidden = true
                self.commentIsHidden.toggle()
            }
        }
    }
    
    private func setupCommentView() {
        if !commentViews.isEmpty {
            for view in commentViews {
                view.removeFromSuperview()
            }
            commentViews.removeAll()
            
        }
        if !photoList.isEmpty {
            if !photoList[currentIndex].getComments().isEmpty {
                let array = photoList[currentIndex].getComments()
                for comment in array {
                    let commentInfoView = CommentInfoView()
                    commentInfoView.translatesAutoresizingMaskIntoConstraints = false
                    commentInfoView.setDate(date: comment.getDate())
                    commentInfoView.setComment(comment: comment.getTextBody())
                    scrollViewContent.addSubview(commentInfoView)
                    if commentViews.isEmpty {
                        commentInfoView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 5).isActive = true
                    } else {
                        commentInfoView.topAnchor.constraint(equalTo: commentViews.last!.bottomAnchor, constant: 5).isActive = true
                    }
                    commentInfoView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 5).isActive = true
                    commentInfoView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -5).isActive = true
                    commentInfoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                    scrollViewBottom.constant += 30
                    commentViews.append(commentInfoView)
                }
               
            }
        }
    }
    
    private func showPhoto() {
           let tap = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
           tap.numberOfTapsRequired = 1
           tap.numberOfTouchesRequired = 1
           currentImage.addGestureRecognizer(tap)
       }
    
    @objc
    private func selectPhoto(_ sender: UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "dzSix", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "showPhoto") as? ShowPhotoController else { return }
        vc.image = imageList[photoList[currentIndex].getName()]!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addImage(_ sender: Any) {
        showImagePickerAlert()
    }
    
    private func saveImage(_ image: UIImage) {
        let data = image.pngData()
        do {
            let imageName = "\(Int(Date().timeIntervalSince1970)).png"
            let photoInfo = PhotoInfo(name: imageName)
            savePhotoInfo(photoInfo: photoInfo)
            try data?.write(to: imagesFolderURL.appendingPathComponent(imageName))
            
            FileManager.default.createFile(atPath: imagesFolderURL.appendingPathComponent(imageName).path, contents: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            saveImage(image)
            setupFileManager()
            setupImage()
            setupCommentView()
        }
        picker.dismiss(animated: true)
    }
}

extension GalleryViewController: GaleryViewDelegate {
    func likePressed() {
        photoList[currentIndex].setLikeState()
        updatePhotoInfo(data: photoList)
    }
    
    func commentAction() {
        commentViewAction()
    }
    
    
}

extension GalleryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        comment.endEditing(true)
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let comment = Comment(body: textComment!, date: "\(hour):\(minute)")
        photoList[currentIndex].addComment(comment: comment)
        updatePhotoInfo(data: photoList)
        print("\(day) \(hour) \(minute)")
        setupCommentView()
        textField.text?.removeAll()
        return true
    }
}
