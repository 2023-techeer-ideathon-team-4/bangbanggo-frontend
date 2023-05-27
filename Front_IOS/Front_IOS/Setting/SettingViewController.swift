//
//  SettingViewController.swift
//  Front_IOS
//
//  Created by 박다미 on 2023/05/27.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var modeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 모드 설정
        setAppMode()
        
        // 모드 변경 이벤트 처리
        modeSegmentControl.addTarget(self, action: #selector(modeSegmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func modeSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // 밝은 모드 선택
            setAppMode(.light)
        case 1:
            // 어두운 모드 선택
            setAppMode(.dark)
        default:
            break
        }
    }
    
    func setAppMode(_ mode: UIUserInterfaceStyle? = nil) {
        if #available(iOS 13.0, *) {
            if let mode = mode {
                // iOS 13 이상에서만 동작하는 코드
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = mode
            } else {
                // 기본 시스템 모드 따르기
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
            }
        } else {
            // iOS 13 미만에서는 밝은 모드로 설정
            view.backgroundColor = .white
        }
    }
}
