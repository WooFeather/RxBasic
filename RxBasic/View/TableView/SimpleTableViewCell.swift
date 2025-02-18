//
//  SimpleTableViewCell.swift
//  RxBasic
//
//  Created by 조우현 on 2/18/25.
//

import UIKit
import SnapKit

final class SimpleTableViewCell: UITableViewCell {

    static let id = "SimpleTableViewCell"
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()
        configView()
    }
    
    private func configHierarchy() {
        addSubview(titleLabel)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
        }
    }
    
    private func configView() {
        titleLabel.font = .systemFont(ofSize: 17)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
