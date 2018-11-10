//
//  ImageCell.swift
//  PinterestLikeApp
//
//  Created by Mac on 10.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit
import PureLayout

class ImageCell: UICollectionViewCell{
    
    var imageView: UIImageView!
    let indicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        addViews()
        setConstrain()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    private func setViews(){
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.configureForAutoLayout()
        indicator.style = .gray
    }
    private func addViews(){
        self.addSubview(indicator)
        self.addSubview(imageView)
    }
    private func setConstrain(){
        
        indicator.autoCenterInSuperview()
        
        imageView.autoPinEdge(.top, to: .top, of: imageView.superview!, withOffset: 10)
        imageView.autoPinEdge(.bottom, to: .bottom, of: imageView.superview!, withOffset: -10)
        imageView.autoPinEdge(.left, to: .left, of: imageView.superview!, withOffset: 10)
        imageView.autoPinEdge(.right, to: .right, of: imageView.superview!, withOffset: -10)
    }
    
}
