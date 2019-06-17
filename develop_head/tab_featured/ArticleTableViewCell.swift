//
//  ArticleTableViewCell.swift
//  develop_head
//
//  Created by zhj on 2019/6/8.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var articeleName: UILabel!
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(_ model:Article) {
        articeleName.text? = model.title!
        subjectName.text? = model.subject!.name!
        
        
        likeBtn.setTitle(model.likeCount!.description, for: UIControl.State.normal)
        
        commentBtn.setTitle(model.commentCount!.description, for: UIControl.State.normal)
        
        favoriteBtn.setTitle(model.favoriteCount!.description, for: UIControl.State.normal)
        
        guard let img = model.subject!.image else{
            return
        }
        icon.kf.setImage(with: URL(string: img))
    }
    
}
