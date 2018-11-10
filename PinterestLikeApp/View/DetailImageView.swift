//
//  DetailImageView.swift
//  PinterestLikeApp
//
//  Created by Mac on 10.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit
import PureLayout
import Hue

class DetailImageView: UIView{
    
    var closeButton: UIButton!
    var imageView: UIImageView!
    var usernameLabel: UILabel!
    var nameLabel: UILabel!
    var likesLabel: UILabel!
    var userImageView: UIImageView!
    var indicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        addViews()
        setConstrain()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func setViews(){
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.configureForAutoLayout()
        usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        usernameLabel.textColor = .gray
        usernameLabel.configureForAutoLayout()
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = .black
        likesLabel = UILabel()
        likesLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        likesLabel.layer.cornerRadius = 10
        likesLabel.textColor = .black
        likesLabel.textAlignment = .center
        likesLabel.configureForAutoLayout()
        userImageView = UIImageView()
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.cornerRadius = 20
        userImageView.layer.masksToBounds = true
        userImageView.clipsToBounds = true
        userImageView.configureForAutoLayout()
        closeButton = UIButton()
        closeButton.layer.cornerRadius = 6
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .black
        closeButton.isHidden = true
        closeButton.configureForAutoLayout()
        indicator.style = .gray
    }
    private func addViews(){
        [imageView, indicator, usernameLabel, nameLabel,
        likesLabel, userImageView, closeButton].forEach{
            self.addSubview($0)
        }
        self.bringSubviewToFront(indicator)
    }
    private func setConstrain(){
        indicator.autoSetDimensions(to: CGSize(width: 50, height: 50))
        indicator.autoConstrainAttribute(.vertical, to: .vertical, of: indicator.superview!)
        indicator.autoConstrainAttribute(.horizontal, to: .horizontal, of: imageView)
        
        imageView.autoPinEdge(.top, to: .top, of: imageView.superview!)
        imageView.autoPinEdge(.left, to: .left, of: imageView.superview!)
        imageView.autoPinEdge(.right, to: .right, of: imageView.superview!)
        imageView.autoSetDimension(.height, toSize: 250)
        
        likesLabel.autoPinEdge(.right, to: .right, of: likesLabel.superview!, withOffset: -15)
        likesLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 10)
        
        userImageView.autoPinEdge(.top, to: .bottom, of: likesLabel, withOffset: 10)
        userImageView.autoPinEdge(.left, to: .left, of: userImageView.superview!, withOffset: 15)
        userImageView.autoSetDimension(.width, toSize: 40)
        userImageView.autoSetDimension(.height, toSize: 40)
        
        usernameLabel.autoPinEdge(.top, to: .bottom, of: likesLabel, withOffset: 5)
        usernameLabel.autoPinEdge(.left, to: .right, of: userImageView, withOffset: 10)
        usernameLabel.autoPinEdge(.right, to: .right, of: usernameLabel.superview!, withOffset: -15)
        
        nameLabel.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 5)
        nameLabel.autoPinEdge(.left, to: .right, of: userImageView, withOffset: 10)
        nameLabel.autoPinEdge(.right, to: .right, of: nameLabel.superview!, withOffset: -15)
        
        closeButton.autoPinEdge(.right, to: .right, of: closeButton.superview!, withOffset: -15)
        closeButton.autoPinEdge(.bottom, to: .bottom, of: closeButton.superview!, withOffset: -15)
        closeButton.autoSetDimension(.width, toSize: 60)
    }
    func setData(image: Image){
        indicator.startAnimating()
        ImageHelper.shared.setImage(image: image, size: .full) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.indicator.stopAnimating()
            }
        }
        usernameLabel.text = image.user.username
        nameLabel.text = image.user.name
        likesLabel.text = "Likes: \(image.likes)"
        if let url = URL(string: image.user.profile_image.small){
            ImageHelper.shared.setImageBy(url: url) {(image) in
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
            }
        }
    }
    
}
