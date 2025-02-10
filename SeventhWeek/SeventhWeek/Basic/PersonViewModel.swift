//
//  PersonViewModel.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/5/25.
//

final class PersonViewModel {
    let navigationTitle = "Person List"
    let resetTitle = "Reset"
    let loadTitle = "Load 10 People"
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let loadTrigger = Observable(())
        let resetTrigger = Observable(())
    }
    
    struct Output {
        let people: Observable<[Person]> = Observable([])
    }
    
    init() {
        input = Input()
        output = Output()
         
        input.loadTrigger.bind { _ in
            self.output.people.value.append(contentsOf: self.generateRandomPeople())
        }
        input.resetTrigger.bind { _ in
            self.output.people.value = []
        }
    }
    
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
}
