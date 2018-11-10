//
//  MainView.swift
//  PinterestLikeApp
//
//  Created by Mac on 09.11.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import UIKit
import Kingfisher

class MainView: UIView{
    
    let cellId = "ImageCellID"
    var collectionView: UICollectionView!
    var images = [Image](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var detailImageView: DetailImageView!
    
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
        let layout: UICollectionViewFlowLayout = PinterestLayout()
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        detailImageView = DetailImageView()
        detailImageView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        detailImageView.layer.cornerRadius = 6
        detailImageView.isHidden = true
        detailImageView.closeButton.addTarget(self, action: #selector(hideDetailView), for: .touchDown)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(hideDetailView))
        detailImageView.addGestureRecognizer(gesture)
        detailImageView.configureForAutoLayout()
    }
    private func addViews(){
        self.addSubview(collectionView)
        self.addSubview(detailImageView)
    }
    private func setConstrain(){
        collectionView.autoPinEdgesToSuperviewEdges()
        detailImageView.autoPinEdge(.top, to: .top, of: detailImageView.superview!, withOffset: 50)
        detailImageView.autoPinEdge(.left, to: .left, of: detailImageView.superview!, withOffset: 25)
        detailImageView.autoPinEdge(.right, to: .right, of: detailImageView.superview!, withOffset: -25)
        detailImageView.autoPinEdge(.bottom, to: .bottom, of: detailImageView.superview!, withOffset: -50)
    }
    private func showDetailView(image: Image){
        if detailImageView.isHidden{
            detailImageView.setData(image: image)
            detailImageView.isHidden = false
            detailImageView.alpha = 0.0
            UIView.animate(withDuration: 0.4) {
                self.detailImageView.alpha = 1.0
            }
        }
    }
    @objc private func hideDetailView(){
        if !detailImageView.isHidden{
            detailImageView.alpha = 1.0
            UIView.animate(withDuration: 0.4, animations: {
                self.detailImageView.alpha = 0.0
            }) { (success) in
                if success{
                    self.detailImageView.imageView.image = nil
                    self.detailImageView.userImageView.image = nil
                    self.detailImageView.isHidden = true
                }
            }
        }
    }
}
extension MainView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageCell{
            let image = images[indexPath.item]
            cell.indicator.startAnimating()
            ImageHelper.shared.setImage(image: image, size: .small) { (image) in
                cell.imageView.image = image
                cell.indicator.stopAnimating()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        showDetailView(image: image)
    }
}
extension MainView: PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = images[indexPath.item]
        let ratio = image.width/image.height
        let width = Int(UIScreen.main.bounds.width/2)*ratio
        return CGFloat(width)
    }
}
