//
//  Cell.swift
//  draw
//
//  Created by do duy hung on 20/09/2016.
//  Copyright © 2016 do duy hung. All rights reserved.
//

import UIKit
class Cell : UICollectionViewCell{
    let kCellWidth: CGFloat = 44
    var filteredImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    func addSubviews() {
        if (filteredImageView == nil) {
            filteredImageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            
            filteredImageView.layer.borderColor = tintColor.CGColor
            contentView.addSubview(filteredImageView)
        }
        
    }
    override var selected: Bool
        {
        didSet
        {
            filteredImageView.layer.borderWidth = selected ? 2 : 0
        }
    }


}
