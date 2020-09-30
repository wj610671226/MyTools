//
//  SearchView.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/12.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit
import SnapKit

enum SearchViewType{
    case normal
    case list
}

class SearchView: UIView {
    
    public static let height = 66

    let searchImageView = UIImageView()
    let searchTextField = UITextField()
    let searchBackgroundView = UIView()
    let type: SearchViewType!
    var listBtn: UIButton?
    
    init(_ type: SearchViewType) {
        self.type = type
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: Int(Screen.width), height: SearchView.height)
        creatUI()
        
        //warning txy
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        if self.type != .normal {
            listBtn = UIButton()
            self.addSubview(listBtn!)
            listBtn?.setImage(UIImage(named: "icons_sort"), for: .normal)
            listBtn?.addTarget(self, action: #selector(listBtnClicked), for: .touchUpInside)
        }
        
        self.addSubview(searchBackgroundView)
        searchBackgroundView.backgroundColor = UIColor.init(hex: 0xF1F3F5)
        searchBackgroundView.layer.cornerRadius = 6
        
        searchBackgroundView.addSubview(searchImageView)
        searchImageView.image = UIImage(named: "icons_search")
        searchImageView.contentMode = .scaleAspectFit
        
        searchBackgroundView.addSubview(searchTextField)
        searchTextField.textColor = UIColor.init(hex: 0x8F9FB3)
        searchTextField.font = UIFont.systemFont(ofSize: 17)
        searchTextField.textAlignment = .left
        searchTextField.placeholder = "搜索全部内容"
        searchTextField.delegate = self
        searchTextField.keyboardType = .asciiCapable
        searchTextField.returnKeyType = .search
        
    }
    
    @objc func listBtnClicked() {
        print("listBtnClicked")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.type == .normal {
            searchBackgroundView.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview().inset(11)
                make.left.right.equalToSuperview().inset(8)
            }
        } else {
            searchBackgroundView.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview().inset(11)
                make.left.equalToSuperview().inset(8)
                make.right.equalTo(listBtn!.snp.left).offset(-8)
            }
            
            listBtn!.snp.makeConstraints { (make) in
                make.right.equalToSuperview().inset(8)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(44)
            }
        }
        
        searchImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(28)
        }
        
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(searchImageView.snp.right).offset(6)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(8)
        }
    }
}

extension SearchView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if newLength > 20 {
            DebugLog.info("输入字符超出长度限制")
        }
        return newLength <= 20 // Bool
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
