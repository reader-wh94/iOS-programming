//
//  FacilityGroup.swift
//  ch10-1891321-stackView
//
//  Created by mac028 on 2021/05/06.
//

import Foundation

class FacilityGroup{
    var facilitys = [Facility]()
    
    init() {
        Facility.count = 0
    }
    func testData(){
        for _ in 0...10{
            facilitys.append(Facility(random: true))
        }
    }
    func count() -> Int{
        return facilitys.count
    }
    func addFacility(facility:Facility){
        facilitys.append(facility)
    }
    func modifyFacility(facility: Facility, index: Int){
        facilitys[index] = facility
    }
    func removeFacility(index: Int) {
        facilitys.remove(at: index)
    }
}
