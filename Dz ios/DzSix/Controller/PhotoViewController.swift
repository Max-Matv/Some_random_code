//
//  PhotoViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 26.Apr.22.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak private var addImageButton: UIButton!
    
    private var currentIndex: Int = 0
    private var mainImage = UIImageView()
    private var secondImage = UIImageView()
    private var photoList: [UIImage]?
    private var button = UIButton(type: .custom)
    private var favoriteStatus = false
    private var mainImageIsEnable = true
    private let password = "password"
    private let documentsFolderURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private lazy var imagesFolderURL: URL = documentsFolderURL.appendingPathComponent("images")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeDirection()
        mainImage.dropShadow()
        secondImage.dropShadow()
        setupFileManager()
        showPhoto()
        setupImageView()
    }
    
    
    
    @IBAction func addImage(_ sender: Any) {
        showImagePickerAlert()
        
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
    
    private func showImagePickerAlert() {
        
        let alert = AlertView(frame: view.bounds)
        alert.addButton(title: "Gallery", style: .normal, action: UIAction(handler: { _ in
            self.showImagePicker(camera: false)
        }))
        alert.addButton(title: "Cancel", style: .normal, action: UIAction(handler: { _ in
            
        }))
        view.addSubview(alert)
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupButton()
    }
    
    private func showPhoto() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        let secondTap = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        mainImage.addGestureRecognizer(tap)
        mainImage.isUserInteractionEnabled = true
        secondImage.addGestureRecognizer(secondTap)
        secondImage.isUserInteractionEnabled = true
    }
    
    private func setupButton() {
        addImageButton.layer.cornerRadius = 20
        addImageButton.layer.borderWidth = 1
    }
    
    @objc
    private func selectPhoto(_ sender: UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "dzSix", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "showPhoto") as? ShowPhotoController else { return }
        vc.image = photoList![currentIndex]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc
    private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if let photoList = photoList {
            switch sender.direction {
            case .right:
                if currentIndex == photoList.startIndex {
                    currentIndex = photoList.endIndex
                }
                if mainImageIsEnable {
                    swipeOn(swipe: .right, firstImage: self.mainImage, secondImage: self.secondImage)
                    mainImageIsEnable = false
                } else {
                    swipeOn(swipe: .right, firstImage: self.secondImage, secondImage: self.mainImage)
                    mainImageIsEnable = true
                }
                
            case .left:
                if currentIndex == photoList.count - 1 {
                    currentIndex = photoList.startIndex - 1
                }
                if mainImageIsEnable {
                    swipeOn(swipe: .left, firstImage: self.mainImage, secondImage: self.secondImage)
                    mainImageIsEnable = false
                } else {
                    swipeOn(swipe: .left, firstImage: self.secondImage, secondImage: self.mainImage)
                    mainImageIsEnable = true
                }
            default:
                return
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Insert password", message: nil, preferredStyle: .alert)
        let checkButton = UIAlertAction(title: "Ok", style: .default) { [self] action in
            if alert.textFields?.first?.text != password {
                alert.message = "Incorrect password!"
                self.present(alert, animated: true, completion: nil)
            }
        }
        alert.addTextField { text in
            text.isSecureTextEntry = true
        }
        alert.addAction(checkButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func swipeOn(swipe: SwipeOn, firstImage: UIImageView, secondImage: UIImageView) {
        switch swipe {
            
        case .left:
            if let photoList = photoList {
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    firstImage.frame.origin.x = self.view.frame.minX - 300
                }
                currentIndex += 1
                secondImage.image = photoList[currentIndex]
                secondImage.frame.origin.x = view.bounds.maxX
                UIImageView.animate(withDuration: 0.5, delay: 0, options: []) {
                    secondImage.frame.origin.x = self.view.center.x - 100
                    secondImage.frame.origin.y = self.view.center.y - 100
                }
            }
         
        case .right:
            if let photoList = photoList {
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    firstImage.frame.origin.x = self.view.bounds.maxX
        
                }
                currentIndex -= 1
                secondImage.image = photoList[currentIndex]
                secondImage.frame.origin.x = view.bounds.minX - 200
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    secondImage.frame.origin.x = self.view.center.x - 100
                    secondImage.frame.origin.y = self.view.center.y - 100
                }
                
            }
        }
    }
    
    private func setupFileManager() {
        if FileManager.default.fileExists(atPath: imagesFolderURL.path) == false {
            try? FileManager.default.createDirectory(at: imagesFolderURL, withIntermediateDirectories: false)

        }
        let array : [UIImage] = [UIImage(named: "denmark")! as UIImage, UIImage(named: "ierland")! as UIImage, UIImage(named: "lithuania")! as UIImage, UIImage(named: "netherland")! as UIImage, UIImage(named: "unst")!as UIImage]
        photoList = array
        let imageNames = try! FileManager.default.contentsOfDirectory(atPath: imagesFolderURL.path).filter({$0.contains(".png")}).sorted()
        let imageURL = documentsFolderURL.appendingPathComponent("images")
        for image in imageNames {
            let images =  imageURL.appendingPathComponent(image)
            let data = try! Data(contentsOf: images)
            let photo = UIImage(data: data)!
            photoList?.append(photo)
        }
    }
       
        
    
    private func saveImage(_ image: UIImage) {
        let data = image.pngData()
        do {
            let imageName = "\(Int(Date().timeIntervalSince1970)).png"
            try data?.write(to: imagesFolderURL.appendingPathComponent(imageName))
            
            FileManager.default.createFile(atPath: imagesFolderURL.appendingPathComponent(imageName).path, contents: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupImageView() {
        
        mainImage.frame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
        secondImage.frame = CGRect(x: view.bounds.maxX, y: view.center.y - 100, width: 200, height: 200)
        if let photoList = photoList {
            mainImage.image = photoList.first
        }
        view.addSubview(mainImage)
        view.addSubview(secondImage)
        mainImage.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = favoriteStatus ? .red : .gray
        
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.topAnchor.constraint(equalTo: mainImage.bottomAnchor).isActive = true
        
    }
    
    

}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            saveImage(image)
            setupFileManager()
        }
        picker.dismiss(animated: true)
    }
}
