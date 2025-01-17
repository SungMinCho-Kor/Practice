//
//  VerticalScrollViewController.swift
//  FourthWeek
//
//  Created by 조성민 on 1/17/25.
//

import UIKit

class VerticalScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let button = UIButton()
    let imageView = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        configureLayout()
        configureContentView()
    }
    
    
    private func configureLayout() {
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.backgroundColor = .systemPink
        contentView.snp.makeConstraints { make in
//            make.width.equalTo(scrollView)
//            make.verticalEdges.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
    }
    
    func configureContentView() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(button)
        
        label.backgroundColor = .orange
        imageView.backgroundColor = .yellow
        button.backgroundColor = .green
        
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(900)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.top.equalTo(label.snp.bottom).offset(50)
            make.bottom.equalTo(imageView.snp.top).offset(-50)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
