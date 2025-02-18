//
//  SimpleTableViewController.swift
//  RxBasic
//
//  Created by 조우현 on 2/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleTableViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let items = Observable.just(
        (0..<50).map { "\($0)번입니다" }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        bind()
    }
    
    private func bind() {
        // 커스텀뷰 테스트
//        items
//            .bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewCell.id, cellType: SimpleTableViewCell.self)) { (row, element, cell) in
//                cell.titleLabel.text = "\(element) 인덱스는 바로바로 \(row)"
//            }
//            .disposed(by: disposeBag)
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) 그리고 인덱스는?! \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        // modelSelected 탭한 셀 안의 데이터를 가져오겠다
        tableView.rx.modelSelected(String.self)
            .bind(with: self) { owner, value in
                owner.showAlert(message: "value는 바로! \(value)") {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .bind(with: self) { owner, indexPath in
                owner.showAlert(message: "Accessory를 탭~! \(indexPath.section), \(indexPath.row)") {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension SimpleTableViewController {
    private func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "SimpleTableView"
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        // tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}
