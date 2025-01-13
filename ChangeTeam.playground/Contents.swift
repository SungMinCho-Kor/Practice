import UIKit

/*
 [팀별 좌석 배치도]
 잭님  TV  빔프로젝터
  5    3      1
       4      2
 */
func 돌려돌려돌림판() {
    // 기존 팀별 좌석 배치
    var 팀좌석 = [1, 2, 3, 4, 5]
    for i in 0..<5 {
        print("\(i + 1)팀의 좌석은 \(팀좌석[i]) 입니다.")
    }
    for i in 0..<팀좌석.count - 1 {
        if 팀좌석[i] == i + 1 {
            let randomIndex = (i+1...팀좌석.count-1).randomElement()!
            let temp = 팀좌석[i]
            팀좌석[i] = 팀좌석[randomIndex]
            팀좌석[randomIndex] = temp
        }
    }
    
    print("---------------------------------------")
    for i in 0..<5 {
        print("\(i + 1)팀의 좌석은 \(팀좌석[i]) 입니다.")
    }
    
    
}

돌려돌려돌림판()
/*
 출력결과 예시
 1팀의 좌석은 1 입니다.
 2팀의 좌석은 2 입니다.
 3팀의 좌석은 3 입니다.
 4팀의 좌석은 4 입니다.
 5팀의 좌석은 5 입니다.
 ---------------------------------------
 1팀의 좌석은 5 입니다.
 2팀의 좌석은 3 입니다.
 3팀의 좌석은 1 입니다.
 4팀의 좌석은 2 입니다.
 5팀의 좌석은 4 입니다.
 */
