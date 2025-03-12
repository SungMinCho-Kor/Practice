//
//  BackupViewController.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/10/25.
//

import UIKit
import Zip

class BackupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let backupButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let restoreButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setConstraints()
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    func configure() {
        view.addSubview(backupTableView)
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let path = documentDirectoryPath() else {
            return
        }
        
        let backupFileURL = path.appendingPathComponent(fetchZipList()[indexPath.row])
        
        let vc = UIActivityViewController(
            activityItems: [backupFileURL],
            applicationActivities: nil
        )
        present(vc, animated: true)
    }
    
    private func fetchZipList() -> [String] {
        guard let path = documentDirectoryPath() else {
            return []
        }
        
        do {
            let docs = try FileManager.default.contentsOfDirectory(
                at: path,
                includingPropertiesForKeys: nil
            )
            dump(docs)
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            dump(zip)
            let last = zip.map { $0.lastPathComponent }
            dump(last)
            return last
        } catch {
            print("목록 조회 실패")
        }
        
        return [
            "테스트1",
            "테스트2"
        ]
    }
    
    @objc func backupButtonTapped() {
        /// Document File -> Zip
        // Documnet 위치 조회
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        // 백업할 파일을 조회
        let realmFile = path.appendingPathComponent("default.realm")
        
        // 백업할 파일경로가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path()) else {
            print("백업할 파일이 없습니다.") // 앱 다운로드 후 바로 백업버튼을 누른다면?
            return
        }
        
        // 압축하고자 하는 파일을 urlPath에 추가
        var urlPaths = [URL]()
        urlPaths.append(realmFile)
        
        // 백업할 파일을 압축 파일로 묶는 작업
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "JackArchive") { progress in
                print(progress)
            }
            print("zip location", zipFilePath)
        } catch {
            print("압축 실패")
            // 기기 용량 부족, 화면 dismiss, 다른 탭 전환, 백그라운드
        }
    }
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    @objc private func restoreButtonTapped() {
        let document = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        
        document.delegate = self
        document.allowsMultipleSelection = false
        present(document, animated: true)
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard let path = documentDirectoryPath() else {
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path()) {
            let fileURL = path.appendingPathComponent("JackArchive.zip")
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil) { progress in
                    print(progress)
                } fileOutputHandler: { unzippedFile in
                    print("압축 해제 완료", unzippedFile)
                }
            } catch {
                print("압출 해제 실패")
            }
        }
    }
}
