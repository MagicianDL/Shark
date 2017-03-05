//
//  SKArticleTableViewCell.swift
//  Shark
//
//  Created by Dalang on 2017/3/3.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit

class SKArticleTableViewCell: UITableViewCell {

    // MARK: Properties
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    /// 文章logo
    lazy var articleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    /// 文章标题
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(hexString: "#666666")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    /// 文章日期
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(hexString: "#666666")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: Public Method
extension SKArticleTableViewCell {
    
    /// 配置 Cell
    func confiureCell() {
        articleLogoImageView.image = UIImage(named: "tabbar_home_sel")
        titleLabel.text = "床前明月光，疑是地上霜。举头望明月，低头思故乡"
        dateLabel.text = "2017-03-04"
    }

    
    /// Cell 高度
    class var cellHeight: CGFloat {
        return 100
    }

}

// MARK: Private Method
extension SKArticleTableViewCell {
    
    /// 设置界面
    func setup() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.mainGray
        contentView.addSubview(baseView)
        
        baseView.addSubview(articleLogoImageView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(dateLabel)
        
        layout()
    }
    
    /// 添加布局约束
    func layout() {
        baseView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 0, 10, 0))
        }
        
        articleLogoImageView.snp.makeConstraints { (maker) in
            maker.left.equalTo(8)
            maker.width.equalTo(157)
            maker.height.equalTo(80)
            maker.centerY.equalTo(baseView)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(articleLogoImageView.snp.right).offset(8)
            maker.top.equalTo(articleLogoImageView.snp.top)
            maker.trailing.equalTo(baseView.snp.trailing).offset(-8)
            maker.height.lessThanOrEqualTo(articleLogoImageView.snp.height).multipliedBy(CGFloat(0.7))
        }
        
        dateLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(articleLogoImageView.snp.right).offset(8)
            maker.bottom.equalTo(articleLogoImageView.snp.bottom)
            maker.trailing.equalTo(baseView.snp.trailing).offset(-8)
        }
    }
    
}


