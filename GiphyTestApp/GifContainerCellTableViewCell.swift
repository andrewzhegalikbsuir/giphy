//
//  GifContainerCellTableViewCell.swift
//  GiphyTestApp
//
//  Created by Monya on 11/20/17.
//  Copyright © 2017 ZhegalikInc. All rights reserved.
//

import UIKit
import NukeGifuPlugin

class GifContainerCell: UITableViewCell {
    
    var innerImageView = AnimatedImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        innerImageView.contentMode = .scaleAspectFit
        innerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(innerImageView)
        
        NSLayoutConstraint.activate([
            innerImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            innerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            innerImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            innerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        innerImageView.prepareForReuse()
    }
}

