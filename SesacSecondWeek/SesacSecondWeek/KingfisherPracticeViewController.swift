//
//  KingfisherPracticeViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/3/25.
//

import UIKit
import Kingfisher

class KingfisherPracticeViewController: UIViewController {

    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearCache()
        KingfisherManager.shared.cache.clearDiskCache()
        dump(KingfisherManager.shared.cache.diskStorage)
        dump(KingfisherManager.shared.cache.memoryStorage)
        print("--------------")
        
        leftImageView.kf.setImage(with: URL(string: "https://i.namu.wiki/i/izVXkClWRy9-s5DAkC_lGo3za4Zy9seGH1V6AM0qZJzsckE9eWe6-Hp-1OvJm_DkVv7BL7U0Ar7QB89ApaklkQ.webp"))
        rightImageView.kf.setImage(with: URL(string: "https://i.namu.wiki/i/h01cpKjF51MCkPZBi9-x7RMltpQbztoVgRB_0fnqrGA6S0M_9mcxpptqAmhr1YxCo0fWeErT3DGg55Nb8O2WeA.webp"))
        dump(KingfisherManager.shared.cache.diskStorage)
        dump(KingfisherManager.shared.cache.memoryStorage)
        Task {
            do {
                try await dump(KingfisherManager.shared.cache.diskStorageSize)
            } catch {
                
            }
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
