//
//  PhotoGalleryCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 21.Jun.22.
//

import UIKit

class PhotoGalleryCell: UICollectionViewCell {

    @IBOutlet weak private var photoView: UIImageView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var textField: UITextField!
    
    private var commentText: String?
    private var likeIsEnable = false {
        didSet {
            likeButton.tintColor = likeIsEnable ? .red : .gray
        }
    }
    private var comments: [Comment] = []
    var buttonPressed: () -> Void = {}
    weak var textFieldDelegate: PhotoGalleryCellTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.textField.delegate = self
    }
    @IBAction private func textFieldShouldChange(_ sender: UITextField) {
        commentText = sender.text
    }
    
    func setupCell(value: UIImage) {
        photoView.image = value
    }
    
    func setLikeStatus(status: Bool) {
        likeIsEnable = status
    }
    
    func setupCommentCell(comments: [Comment]) {
        self.comments = comments
        self.tableView.reloadData()
    }
    func addComment(comment: Comment) {
        comments.append(comment)
        tableView.reloadData()
    }
    

    @IBAction func likePressed(_ sender: Any) {
        likeIsEnable.toggle()
        buttonPressed()
    }
}

extension PhotoGalleryCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as? CommentTableViewCell else {
            fatalError()
        }
        cell.setupCell(comment: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension PhotoGalleryCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.textFieldDelegate?.texDidChanged(textField)
        textField.text?.removeAll()
        return true
    }
}

protocol PhotoGalleryCellTextFieldDelegate: AnyObject {
    func texDidChanged(_ textField: UITextField)
}

