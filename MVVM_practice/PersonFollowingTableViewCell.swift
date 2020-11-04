//
//  PersonFollowingTableViewCell.swift
//  MVVM_practice
//
//  Created by Yuki Shinohara on 2020/11/04.
//

import UIKit

protocol PersonFollowingTableViewCellDelegate: AnyObject {
    //Controllerにデータを折り返す
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell,
                                      didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingTableViewCell: UITableViewCell {
    
    static let identifier = "PersonFollowingTableViewCell"
    
    weak var delegate: PersonFollowingTableViewCellDelegate?
    
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        return button
        //ViewModelでFollowかUnfollowかを決めるのでここではその他はノータッチ
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let views = [userNameLabel, userImageView, nameLabel, button]
        for x in views {
            contentView.addSubview(x)
        }
        contentView.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton(){
        guard let viewModel = viewModel else {
            return
        }
        
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        //delegateを通してControllerにデータを渡す(その後そっちで色々できる)
        delegate?.personFollowingTableViewCell(self, didTapWith: newViewModel)
        prepareForReuse() //cellリセット
        configure(with: newViewModel) //新しい値 → Follow/Unfollowの切り替え
    }
    
    func configure(with viewModel: PersonFollowingTableViewCellViewModel){
        self.viewModel = viewModel
        //ViewModelを使って表示部分を作成
        nameLabel.text = viewModel.name
        userNameLabel.text = viewModel.username
        userImageView.image = viewModel.image
        //ViewModelの値を使って表示を決めるのでViewは以下の情報を知らない
        if viewModel.currentlyFollowing {
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        } else {
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .link
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWidth = contentView.frame.height - 10
        userImageView.frame = CGRect(x: 5, y: 5,
                                     width: imageWidth,
                                     height: imageWidth)
        nameLabel.frame = CGRect(x: imageWidth + 10, y: 0,
                                 width: contentView.frame.width - imageWidth,
                                 height: contentView.frame.height / 2)
        userNameLabel.frame = CGRect(x: imageWidth + 10, y: contentView.frame.height / 2,
                                 width: contentView.frame.width - imageWidth,
                                 height: contentView.frame.height / 2)
        button.frame = CGRect(x: contentView.frame.width - 120, y: 10,
                              width: 110, height: contentView.frame.height - 20)
    }
    
    //毎回ボタンの表示をリセット
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        userNameLabel.text = nil
        userImageView.image = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
    }
}
