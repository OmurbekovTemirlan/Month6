//
//  SmsViewConroller.swift
//  myCofeHomeApp
//
//  Created by Apple on 6.5.2024.
//

import Foundation
import SnapKit

protocol SmsViewDelegate: AnyObject {
    func textFieldDidChange(_ textField: UITextField)
    func signInBtn()
}

class SmsViewConroller: BaseViewController {
    
    private let smsView = SmsView()
   
    override func setup() {
        super.setup()
        view.backgroundColor = .systemBackground
        setupAdd()
        setupLayouts()
        smsView.delegate = self
    }
    override func setupAdd() {
        super.setupAdd()
        view.addSubview(smsView)
    }
    override func setupLayouts() {
        super.setupLayouts()
        smsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
extension SmsViewConroller: SmsViewDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let maxLength = 6
        if text.count > maxLength {
            textField.deleteBackward()
        }
    }
    
    func signInBtn() {
        let vc = TabBarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
