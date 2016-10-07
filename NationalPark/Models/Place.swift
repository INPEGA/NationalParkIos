//
//  Place.swift
//  NationalPark
//
//  Created by Peerapun Sangpun on 7/8/2559 BE.
//  Copyright © 2559 Peerapun Sangpun. All rights reserved.
//

import RealmSwift
class Place: Object { // [2]
    dynamic var type_th = ""
    dynamic var type_en = ""
    dynamic var subtype_th = ""
    dynamic var subtype_en = ""
    dynamic var attraction_th = ""
    dynamic var attraction_en = ""
    dynamic var organization_th = ""
    dynamic var organization_en = ""
    dynamic var open_hour = ""
    dynamic var image_url = ""
    
    dynamic var facility = ""
    dynamic var contact = ""
    dynamic var province = ""
    dynamic var district = ""
    dynamic var sub_district = ""
    
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var distance = ""

}