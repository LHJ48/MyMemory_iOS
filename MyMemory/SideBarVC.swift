//
//  SideBarVC.swift
//  MyMemory
//
//  Created by LeeHoJun on 2022/03/20.
//

import UIKit
class SideBarVC: UITableViewController {
    // 목록 데이터 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    // 아이콘 데이터 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png"),
    ]
    
    let nameLabel = UILabel() // 이름 레이블
    let emailLabel = UILabel() // 이메일 레이블
    let profileImage = UIImageView() // 프로필 이미지
    
    let uinfo = UserInfoManager() // 개인 정보 관리 매니저
    
    override func viewDidLoad() {
        // 테이블 뷰의 헤더 역할을 할 뷰을 정의한다.
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        
        headerView.backgroundColor = .brown
        
        // 테이블 뷰의 헤더 뷰로 지정한다.
        self.tableView.tableHeaderView = headerView
        
        // 이름 레이블의 속성을 정의하고, 헤더뷰에 추가한다.
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30) // 위치와 크기를 정의
        self.nameLabel.textColor = .white // 텍스트 색상
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15) // 폰트 사이즈
        self.emailLabel.backgroundColor = .clear // 배경 색상
        
        headerView.addSubview(self.nameLabel) // 헤더 뷰에 추가
        
        // 이메일 레이블의 속성을 정의하고, 헤더 뷰에 추가한다.
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 150, height: 30) // 위치와 크기를 정의
        self.emailLabel.textColor = .white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = .clear // 배경 색상
        
        headerView.addSubview(self.emailLabel) // 헤더 뷰에 추가
        
        // 기본 이미지를 구현한다.
        //let defaulttProfile = UIImage(named: "account.jpg")
        //self.profileImage.image = defaulttProfile // 이미지 등록
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        // 추가) 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2) // 반원 형태로 라운딩
        self.profileImage.layer.borderWidth = 0 // 테두리 두께 0으로
        self.profileImage.layer.masksToBounds = true // 마스크 효과
        view.addSubview(self.profileImage) // 헤더 뷰에 추가
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 큐에서 테이블 셀을 꺼내 든다. 없으면 새로 생성한다.
        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { // 선택된 행이 새글 작성 메뉴일 때
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController().frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController().revealToggle(self)
        } else if indexPath.row == 5 { // 계정 관리
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: true) {
                self.revealViewController().revealToggle(self)
            }
        }
    }
}
