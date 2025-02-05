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
    
    var loadTrigger = Observable(())
    var resetTrigger = Observable(())
    
    var people: Observable<[Person]> = Observable([])
    
    init() {
        loadTrigger.bind { _ in
            self.people.value.append(contentsOf: self.generateRandomPeople())
        }
        resetTrigger.bind { _ in
            self.people.value = []
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
