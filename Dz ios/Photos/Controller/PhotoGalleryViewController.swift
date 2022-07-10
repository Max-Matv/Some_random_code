//
//  PhotoGalleryViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 21.Jun.22.
//

import UIKit

class PhotoGalleryViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    private var photoList: [PhotoInfo] = []
    private var imageList: [String: UIImage] = [:]
    private let documentsFolderURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private lazy var imagesFolderURL: URL = documentsFolderURL.appendingPathComponent("images")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupFileManager()
    }
    @IBAction private func addPhoto(_ sender: Any) {
        showImagePickerAlert()
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
    
    private func setupCollectionView() {
        let key = PhotoGalleryCell.reuseIdentifier
        collectionView.register(UINib(nibName: key, bundle: nil), forCellWithReuseIdentifier: key)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        var images: [String: UIImage] = [:]
        let photos: [PhotoInfo] = getPhotoInfo()
        for imageName in imageNames {
            let image = imageURL.appendingPathComponent(imageName)
            let data = try! Data(contentsOf: image)
            let photo = UIImage(data: data)
            images[imageName] = photo
        }
        photoList = photos
        imageList = images
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

extension PhotoGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCell.reuseIdentifier, for: indexPath) as? PhotoGalleryCell else {
            fatalError()
        }
        cell.setupCell(value: imageList[photoList[indexPath.row].getName()]!)
        cell.setLikeStatus(status: photoList[indexPath.row].getLikeState())
        cell.buttonPressed = { [self] in
            photoList[indexPath.row].setLikeState()
            updatePhotoInfo(data: photoList)
        }
        cell.setupCommentCell(comments: photoList[indexPath.row].getComments())
        let commentv = Comment(body: "this is \(indexPath.item)", date: "11")
        cell.addComment(comment: commentv)
        cell.textFieldDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "dzSix", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "showPhoto") as? ShowPhotoController else { return }
        vc.image = imageList[photoList[indexPath.row].getName()]!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PhotoGalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            saveImage(image)
            setupFileManager()
            collectionView.reloadData()
        }
        picker.dismiss(animated: true)
    }
}

extension PhotoGalleryViewController: PhotoGalleryCellTextFieldDelegate {
    func texDidChanged(_ textField: UITextField) {
        guard let idexOfItem = collectionView.indexPathsForVisibleItems.first else { return }
        guard let commentText = textField.text else { return }
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let comment = Comment(body: commentText, date: "\(hour):\(minute)")
        photoList[idexOfItem.row].addComment(comment: comment)
        updatePhotoInfo(data: photoList)
        collectionView.reloadData()
    }
    
    
}

