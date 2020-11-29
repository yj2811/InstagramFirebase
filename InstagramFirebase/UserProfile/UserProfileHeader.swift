//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Yogakshi Jaiman on 27/11/20.
//  Copyright © 2020 Yogakshi Jaiman. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell{
    
    var user: User?{
        didSet{
            setProfileImage()
            
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
//        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) ]))
        
        label.attributedText = attributedText
    
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
       
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) ]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) ]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 80, height:80))
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, bottom: gridButton.topAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 12, bottom: 0, right: 12))
        
        setupUserStatsView()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, leading: postsLabel.leadingAnchor, bottom: nil, trailing: followingLabel.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 34))
        
    }
    
    fileprivate func setupUserStatsView(){
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))
    }
    
    fileprivate func setupBottomToolbar(){
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 50))
        
        topDividerView.anchor(top: stackView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 0.5))
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 0.5))
        
    }
    
    
    
    fileprivate func setProfileImage(){
        guard let profileImageUrl = user?.profileImageUrl else {return}
        guard let url = URL(string: profileImageUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // Check for error and then construct image using data
            if let err = err{
                print("Failed to fetch profile image:", err)
                return
            }
            
            // Perhaps check for response status of 200 (HTTP OK)
            
            guard let data = data else {return}
            
            let image = UIImage(data: data)
            
            //Need to get back onto the main UI Thread
            DispatchQueue.main.async{
                self.profileImageView.image = image
            }
        }.resume()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


